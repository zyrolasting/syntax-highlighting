#lang xiden

(define package "syntax-highlighting")
(define provider "anonymous")
(define edition "default")
(define revision-number 0)
(define revision-names '("3.9.0"))
(define os-support '(unix))

(define inputs
  (list (input "python-source.tgz"
               (sources "https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz")
               (integrity 'md5
                          (hex "e19e75ec81dd04de27797bf3f9d918fd")))
        (input "pygments.zip"
               (sources "https://github.com/pygments/pygments/archive/master.zip")
               (integrity 'sha384
                          (base64 "")))))

(define (build target)
  (call-with-input (input-ref inputs "python-source.tgz") unpack)
  (call-with-input (input-ref inputs "pygments.zip") unpack)
  (current-directory "Python-3.9.0")

  (run (build-path (current-directory) "configure")
       "--enable-optimizations"
       "--prefix" (build-path (current-directory)))

  (run "make")
  (run "make" "install")

  )
