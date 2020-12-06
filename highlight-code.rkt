#lang racket/base

(provide highlight-code)

(require racket/match
         racket/port
         racket/runtime-path
         racket/system
         xml)

(define-runtime-path pygmentize "./py/bin/pygmentize")

(module+ main (apply system* pygmentize (vector->list (current-command-line-arguments))))

(define (highlight-code lang code)
  (cond [(bytes? code)
         (highlight-code lang (open-input-bytes code))]
        [(string? code)
         (highlight-code lang (open-input-string code))]
        [(input-port? code)
         (let-values ([(subproc from-stdout to-stdin from-stderr)
                       (subprocess #f #f #f 'new pygmentize "-l" lang "-f" "html")])
           (dynamic-wind void
                         (λ ()
                           (copy-port code to-stdin)
                           (flush-output to-stdin)
                           (close-output-port to-stdin)
                           (subprocess-wait subproc)
                           (define exit-code (subprocess-status subproc))
                           (if (eq? exit-code 0)
                               (xml->xexpr (document-element (read-xml/document from-stdout)))
                               (copy-port from-stderr (current-error-port))))
                         (λ ()
                           (close-input-port from-stdout)
                           (close-input-port from-stderr)
                           (close-output-port to-stdin))))]))
