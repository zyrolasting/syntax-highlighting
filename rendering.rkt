#lang racket/base

(require racket/contract
         racket/format)

(define (es str) (format "\033[~am" str))
(define (bg code) (es (~a "48;5;" code)))
(define (fg code) (es (~a "38;5;" code)))

(define reset (es "0"))
(define underlined (es "4"))
(define bold (es "1"))
