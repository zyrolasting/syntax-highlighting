#lang racket/base

(require racket/contract
         "token-classes.rkt")

(define channel/c (λ (x) (and (>= x 0) (<= x 255))))

(provide (contract-out
          [struct color ((r channel/c) (g channel/c) (b channel/c) (a channel/c))]
          [struct style ((fg color?) (bg color?))]
          [default-style style?]
          [palette? (-> any/c boolean?)]
          [make-default-palette (-> palette?)]))

;; Implementation follows
(require racket/dict
         racket/file
         racket/function
         racket/runtime-path)

(struct color (r g b a) #:transparent)
(struct style (fg bg) #:transparent)

(define (palette? p)
  (and (dict? p)
       (for/fold ((result #t)
                  #:result result)
                 ((token-class (in-accepted-token-classes)))
         #:break (not result)
         (and result (style? (dict-ref p token-class #f))))))

(define default-style
  (style (color 0 0 0 255)
         (color 0 0 0 0)))

(define (make-default-palette)
  (for/fold ((working (make-immutable-hash)))
            ((token-class (in-accepted-token-classes)))
    (hash-set working token-class default-style)))
