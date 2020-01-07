#lang scribble/manual

@require[@for-label[syntax-highlighting
                    racket/base]]

@title{@tt{syntax-highlighting}}
@author{Sage Gerard}

This collection is for general-purpose syntax highlighting in Racket.
This project is young and incomplete. If you wish to fast track development,
please see here.

@defmodule[syntax-highlighting]

@section{A Baby Step}
To highlight a code fragment, just provide a string to a procedure of
name @tt{highlight-X}, where @tt{X} is one of the built-in languages.

@racketmod[#:file "colorful-hello.rkt"
racket/base

(require syntax-highlighting)

(displayln
  (highlighted->string/ansi-colored
    (highlight-html5 "<h1>Hello, world!</h1>")))]

If you run this program using your terminal, you will see colorized
output thanks to @racket[highlighted->string/ansi-colored].

Notice that we don't need to specify an entire HTML document. The
highlighters are expected to deal with incomplete markup or programs
to maximize usability.

@subsection{Change Colors}
Use @racket[#:palette] with a highlighter procedure to select an
available palette.

@racketmod[#:file "colorful-hello.rkt"
racket/base

(require syntax-highlighting)

(displayln
  (highlighted->ansi-colored
    (highlight-html #:palette sunshine
                    "<h1>Hello, world!</h1")))]

You can change colors for call to a highlighter. That allows you to
use a different palette within the same language for emphasis, or use
a new palette with a different language embedded within another.

Highlighter procedures also accept input ports.

@racketblock[
(require syntax-highlighting)
(define highlighted (call-with-input-file "doc.html" highlight-html))]

@section{Writing Your Own Highlighter}

A highlighter is a @racketmodname[parsack] parser that classifies
characters.

@section{Contributing}

I can't write precise highlighters for every language because that's
too much for one person to do.  If you want to help this project gain
coverage over more languages, then submit a pull request with your
highlighter implementation to the project.
