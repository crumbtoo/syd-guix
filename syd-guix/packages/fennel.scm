(define-module (syd-guix packages fennel)
  #:use-module (guix)
  #:use-module (guix build utils)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages curl))

(define-public fennel-ls
  (package
    (name "fennel-ls")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
               "https://git.sr.ht/~xerool/fennel-ls/archive/"
               version
               ".tar.gz"))
        (sha256
          (base32 "0nb3yclv9v2mwcnam5djvhg0vgmdsk0gavbvq1ar5v2j0m9pzr7f"))))
    (build-system gnu-build-system)
    (arguments
      '(#:tests? #f
        #:test-target "test"
        #:phases (modify-phases %standard-phases
                   (delete 'configure)
                   (add-before 'build 'rm-deps
                     (lambda _
                       (invoke "make" "rm-deps"))))
        #:make-flags
        (let ((out (assoc-ref %outputs "out")))
          (list
            (string-append "DESTDIR=" out)
            "PREFIX="))))
    (inputs (list lua-5.4 fennel))
    (home-page "https://git.sr.ht/~xerool/fennel-ls/refs")
    (license license:expat)
    (synopsis "Provides intelligent editing features for Fennel files")
    (description "A language server for Fennel.")))

