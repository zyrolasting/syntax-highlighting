#lang xiden

(define package "syntax-highlighter")
(define provider "sagegerard.com")
(define edition "default")
(define revision-number 0)
(define revision-names '("3.9.0"))
(define os-support '(unix))

(define inputs
  (list (input "python-source.tgz"
               (sources "https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz")
               (integrity 'md5 (hex "e19e75ec81dd04de27797bf3f9d918fd")))))

(define (build target)
  (call-with-input (input-ref inputs "python-source.tgz") unpack)
  (current-directory "Python-3.9.0")
  (run (build-path (current-directory) "configure")
       "--enable-optimizations"
       "--prefix" (build-path (current-directory))
  (run "make")
  (run "make" "install"))
