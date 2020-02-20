#lang racket/base

; WARNING: This is a stopgap that transmits your code to
; http://markup.su/api/highlighter. Use ONLY for code that
; is already public knowledge.

(require racket/contract
         racket/format
         racket/port
         racket/set
         net/url
         net/uri-codec
         xml)

(provide (contract-out
          [highlight-code/insecure (-> accepted-lang/c
                                       accepted-theme/c
                                       string?
                                       xexpr?)]))
(define CRLF "\r\n")
(define boundary "X$X")
(define (lines . xs) (foldl (λ (v res) (~a res v CRLF)) "" xs))
(define end-message (lines (~a "--" boundary "--")))
(define form-header (~a "Content-Type: multipart/form-data; charset=utf-8; boundary=" boundary))

(define (chunk name val)
  (lines
   (~a "--" boundary)
   (format "Content-Disposition: form-data; name=\"~a\"" name)
   ""
   (~a val)))

(define port->xexpr (compose string->xexpr port->string))

(define (highlight-code/insecure language theme source)
  (with-handlers ([exn:fail? (λ _ `(pre ,source))])
    (port->xexpr
     (post-pure-port (string->url "http://markup.su/api/highlighter")
                     (string->bytes/utf-8 (~a (chunk "language" language)
                                              (chunk "theme" theme)
                                              (chunk "source" source)
                                              end-message))
                     (list form-header)))))

(define accepted-lang/c (symbols
'|Active4D|
'|Active4D Config|
'|Active4D Library|
'|Ada|
'|Ant|
'|ANTLR|
'|Apache|
'|AppleScript|
'|ASP|
'|ASP vb.NET|
'|Bash|
'|BibTeX|
'|Bison|
'|Blog — HTML|
'|Blog — Markdown|
'|Blog — Text|
'|Blog — Textile|
'|Bulletin Board|
'|C|
'|C++|
'|C++ Qt|
'|camlp4|
'|CMake Listfile|
'|ColdFusion|
'|Context Free|
'|CSS|
'|CSV|
'|D|
'|DokuWiki|
'|Doxygen|
'|Dylan|
'|Eiffel|
'|Erlang|
'|F-Script|
'|Fortran - Modern|
'|Fortran - Punchcard|
'|FXScript|
'|Gettext|
'|Grails Server Page|
'|Graphviz (DOT)|
'|Greasemonkey|
'|Gri|
'|Groovy|
'|GTD|
'|GTDalt|
'|Haskell|
'|HTML|
'|HTML (Active4D)|
'|HTML (ASP)|
'|HTML (ASP.net)|
'|HTML (Django)|
'|HTML (Erlang)|
'|HTML (Mason)|
'|HTML (Rails)|
'|HTML (Tcl)|
'|HTML (Template Toolkit)|
'|iCalendar|
'|Inform|
'|Ini|
'|Installer Distribution Script|
'|Io|
'|Java|
'|JavaDoc|
'|Java Properties|
'|JavaScript|
'|JavaScript (Rails)|
'|JavaScript jQuery|
'|JavaScript Prototype & Script.aculo.us|
'|Javascript YUI|
'|Java Server Page (JSP)|
'|JSFL|
'|JSON|
'|JUnit Test Report|
'|Language Grammar|
'|LaTeX|
'|LaTeX Beamer|
'|LaTeX Log|
'|LaTeX Memoir|
'|LaTeX Rdaemon|
'|Lex/Flex|
'|Lid File|
'|Lighttpd|
'|LilyPond|
'|Lisp|
'|Literate Haskell|
'|Logo|
'|Logtalk|
'|Lua|
'|MacPorts Portfile|
'|Mail|
'|Makefile|
'|Makegen|
'|Man|
'|Markdown|
'|MATLAB|
'|Maven POM|
'|Mediawiki|
'|MEL|
'|MIPS Assembler|
'|Modula-3|
'|mod_perl|
'|MoinMoin|
'|MooTools|
'|Movable Type|
'|Movable Type (MT only)|
'|MultiMarkdown|
'|Objective-C|
'|Objective-C++|
'|Objective-J|
'|OCaml|
'|OCamllex|
'|OCamlyacc|
'|Octave|
'|OpenGL|
'|Pascal|
'|Perl|
'|Perl HTML-Template|
'|PHP|
'|Plain Text|
'|PmWiki|
'|Postscript|
'|Processing|
'|Prolog|
'|Property List|
'|Prototype & Script.aculo.us (JavaScript) Bracketed|
'|Python|
'|Python Django|
'|qmake Project file|
'|Quake Style .cfg|
'|R|
'|Ragel|
'|R Console (R.app)|
'|R Console (Rdaemon)|
'|R Console (Rdaemon) Plain|
'|Rd (R Documentation)|
'|Regular Expressions (Oniguruma)|
'|Regular Expressions (Python)|
'|Release Notes|
'|Remind|
'|reStructuredText|
'|Rez|
'|RJS|
'|Ruby|
'|Ruby Haml|
'|Ruby on Rails|
'|S5 Slide Show|
'|Scala|
'|Scheme|
'|Scilab|
'|Setext|
'|Slate|
'|Smarty|
'|SQL|
'|SQL (Rails)|
'|SSH Config|
'|Standard ML|
'|Standard ML - CM|
'|Strings File|
'|Subversion commit message|
'|SWeave|
'|SWIG|
'|Tcl|
'|TeX|
'|TeX Math|
'|Textile|
'|Thrift|
'|TSV|
'|Twiki|
'|Txt2tags|
'|Vectorscript|
'|XML|
'|XML strict|
'|XSL|
'|YAML|))

(define accepted-theme/c (symbols
'|Active4D|
'|All Hallow's Eve|
'|Amy|
'|Blackboard|
'|Cobalt|
'|Dawn|
'|Eiffel|
'|Espresso Libre|
'|IDLE|
'|LAZY|
'|Mac Classic|
'|MagicWB (Amiga)|
'|Pastels on Dark|
'|Slush & Poppies|
'|Solarized (dark)|
'|Solarized (light)|
'|SpaceCadet|
'|Sunburst|
'|Twilight|
'|Zenburnesque|
'|iPlastic|))
