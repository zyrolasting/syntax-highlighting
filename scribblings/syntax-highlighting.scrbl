#lang scribble/manual

@require[@for-label[syntax-highlighting/lusever
                    racket/base
                    xml]]

@title{@tt{syntax-highlighting}}
@author{Sage Gerard}

This collection is for general-purpose syntax highlighting in Racket.
This project is incomplete. If you wish to fast track development,
please consider @hyperlink["https://sagegerard.com/subscribe.html"]{supporting it}.

@section{An Insecure Stopgap}

@defmodule[syntax-highlighting/lusever]

Syntax highlighting is a hard problem. Right now, there's no pure-Racket
solution for it. You can either install a seperate app, or use this quick
and very... very dirty module. This module will be taken down the moment
a better solution appears.

@defproc[(highlight-code/insecure [language symbol?]
                                  [theme symbol?]
                                  [code string?])
                                  xexpr?]{
This module highlights your code using
@hyperlink["http://markup.su/highlighter/api"]{http://markup.su/highlighter/api},
by @hyperlink["http://lusever.ru/"]{lusever}. Go to the former link to see accepted
values for @racket[language] and @racket[theme]. The procedure will return an
X-expression representing an HTML @tt{pre} element, with inline styles applied
to code according to the theme you select.

If you see a value with spaces
and special characters like @litchar{R Console (R.app)}, pass it to this procedure
as @racket['|R Console (R.app)|].

@bold{BEWARE: Do NOT pass anything you do not want shared to this
procedure!}  The service only uses HTTP, so whatever you send is clear
text.

Obviously, this procedure only works online. If it fails to highlight
your code, it will return said code in a @tt{pre} element, but without
any styles.
}