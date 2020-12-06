#lang racket/base

(provide highlight-code)

(require racket/match
         racket/port
         racket/runtime-path
         racket/system
         threading
         xml
         (only-in html read-html-as-xml))

(define-runtime-path pipe.py "pygments-integration.py")

(define (read-html-as-xexprs port)
  (~>> (read-html-as-xml port)
       (element #f #f 'root '())
       xml->xexpr
       decode-ampersands-in-attributes
       cddr))

(define (decode-ampersands-in-attributes x)
  (match x
    [`(,tag ([,ks ,vs] ...) . ,els)
     `(,tag
       ,(for/list ([k ks]
                   [v vs])
          (list k (regexp-replace* "&amp;" v "\\&")))
       ,@(map decode-ampersands-in-attributes els))]
    [v v]))

(define (highlight-code lang code)
  (match-define (list from-proc to-proc pid from-proc/err proc)
    (process* (find-executable-path "python3")
              pipe.py))
  (displayln lang to-proc)
  (copy-port (open-input-string code)
             to-proc)
  (close-output-port to-proc)
  (proc 'wait)
  (read-html-as-xexprs from-proc))
