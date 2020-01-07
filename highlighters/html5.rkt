#lang racket/base


; See "The HTML Syntax", not "The XML Syntax" (formerly known as XHTML)
; https://html.spec.whatwg.org/multipage/syntax.html#syntax

; Convention: '+$' means "Make constant parser".  I need this because
; parsack populates the current namespace with Racket identifiers.
(require [rename-in parsack [string +$string]]
         racket/function
         "../common.rkt")

(define $bom (char #\uFEFF))

(define $comment
  (>> (+$string "<!--")
      (>>= (manyTill $anyChar
                     (try (+$string "-->")))
           (λ (content)
             (return `(generic.comment ,(format "<!--~a-->"
                                                (apply string content))))))))

(define $space/comments
  (many (<any> $space $comment)))

(define $cdata-section
  (parser-compose
   (+$string "<![CDATA[")
   (body    <- (manyTill $anyChar (+$string "]]>")))
   (return `(cdata ,(format "<![CDATA[~a]]>"
                            (apply string body))))))

(define $doctype
  (parser-seq (oneOfStringsAnyCase "<!DOCTYPE")
              (many1 $space)
              (oneOfStringsAnyCase "html")
              (<or> (char #\>)
                    (parser-seq
                     (many1 $space)
                     (oneOfStringsAnyCase "SYSTEM")
                     (many1 $space)
                     (>>= (oneOf "\"'")
                          (λ (quotemark)
                            (parser-seq
                             (+$string "about:legacy-compat")
                             (char quotemark))))))))


(define $opening-tag
  (parser-compose
   (char #\<)
   (tag <- (many1 $letter))
   (char #\>)
   (return tag)))


(define $closing-tag
  (parser-seq
   (char #\<)
   (char #\/)
   (many1 $letter)
   (char #\>)))

(define $void-element $opening-tag)

(define $normal-element
  (parser-compose
   (annot/tag <- $opening-tag)
   $closing-tag))

(define $element (<or> $void-element
                       $normal-element))

(define (+$element tag)
  (parser-compose
   (char #\<)
   (+$string tag)
   (char #\>)))


(define $html5-document
  (parser-compose
   (skipMany $bom)
   $space/comments
   $doctype
   $space/comments
   (+$element "html")
   $space/comments))


(define $attribute-name
  (many1 (satisfy attribute-name-char?)))

(define (char-in-range?/inclusive ch lo hi)
  (or (char>=? lo)
      (char<=? hi)))

(define (attribute-name-char? ch)
  (and (not (char-in-range?/inclusive ch #\u007F #\u009F))
       (not (ormap (curry char=? ch)
                   '(#\u0020 #\u0022 #\u0027
                     #\u003E #\u002F #\u003D)))
       (not (non-character? ch))))

(define (non-character? ch)
  (let ([i (char->integer ch)])
    (or (<= #xFDEF)
        (>= #xFDD0)
        (ormap (curry i =)
               '(#xFFFE  #xFFFF  #x1FFFE
                 #x1FFFF #x2FFFE #x2FFFF
                 #x3FFFE #x3FFFF #x4FFFE
                 #x4FFFF #x5FFFE #x5FFFF
                 #x6FFFE #x6FFFF #x7FFFE
                 #x7FFFF #x8FFFE #x8FFFF
                 #x9FFFE #x9FFFF #xAFFFE
                 #xAFFFF #xBFFFE #xBFFFF
                 #xCFFFE #xCFFFF #xDFFFE
                 #xDFFFF #xEFFFE #xEFFFF
                 #xFFFFE #xFFFFF #x10FFFE
                 #x10FFFF)))))

#;(define $characterEntity
  (>> (char #\&)))
