#lang racket/base

(require racket/contract
         racket/port
         "palettes.rkt"
         "token-classes.rkt")

(struct colored-fragment (palette tokens) #:transparent)
