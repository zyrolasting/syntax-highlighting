#lang racket/base

(require racket/contract
         racket/set
         racket/sequence)

(provide
 (contract-out
  (in-accepted-token-classes (-> sequence?))
  (accepted-token-classes (set/c symbol?))
  (accepted-token-class? (-> any/c boolean?))))

(define accepted-token-classes
  (apply set
         '(token
           text
           whitespace
           escape
           error
           other
           keyword
           keyword.constant
           keyword.declaration
           keyword.namespace
           keyword.pseudo
           keyword.reserved
           keyword.type
           name
           name.attribute
           name.builtin
           name.builtin.pseudo
           name.class
           name.constant
           name.decorator
           name.entity
           name.exception
           name.function
           name.function.magic
           name.property
           name.label
           name.namespace
           name.other
           name.tag
           name.variable
           name.variable.class
           name.variable.global
           name.variable.instance
           name.variable.magic
           literal
           literal.date
           string
           string.affix
           string.backtick
           string.char
           string.delimiter
           string.doc
           string.double
           string.escape
           string.heredoc
           string.interpol
           string.other
           string.regex
           string.single
           string.symbol
           number
           number.bin
           number.float
           number.hex
           number.integer
           number.integer.long
           number.oct
           operator
           operator.word
           punctuation
           comment
           comment.hashbang
           comment.multiline
           comment.preproc
           comment.preprocfile
           comment.single
           comment.special
           generic
           generic.deleted
           generic.emph
           generic.error
           generic.heading
           generic.inserted
           generic.output
           generic.prompt
           generic.strong
           generic.subheading
           generic.traceback)))

(define (accepted-token-class? v)
  (set-member? accepted-token-classes v))

(define (in-accepted-token-classes)
  (in-set accepted-token-classes))
