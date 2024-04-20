(define-module (syd-guix packages leininghen)
               #:use-module (guix)
               #:use-module (guix utils)
               #:use-module ((guix licenses) #:prefix license:)
               #:use-module (guix build utils)
               #:use-module (guix build-system copy)
               #:use-module (guix git-download)
               #:use-module (gnu packages java)
               #:use-module (gnu packages certs)
               #:use-module (gnu packages wget)
               #:use-module (gnu packages tls)
               #:use-module (gnu packages base)
               #:use-module (gnu packages bash))

(define leininghen-boot
  (package
    (name "leininghen-boot")
    (version "stable")
    (source
      (origin
        (method url-fetch)
        (uri "https://codeberg.org/leiningen/leiningen/raw/branch/stable/bin/lein")
        (sha256 (base32 "1m1b0d3ajirqwqm7g5ls3i6ba1x8zyn146cgy40x62fbabi3sgpq"))))
    (build-system copy-build-system)
    (propagated-inputs (list wget nss-certs openjdk21))
    (arguments
      `(#:install-plan '(("lein" "bin/lein-stable"))
        #:phases
        (modify-phases %standard-phases
                       #;(add-after 'patch-source-shebangs 'patch-wget
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (chmod "lein" #o700)))
          (add-before 'install 'make-executable
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (chmod "lein" #o700))))))
    (synopsis "synopsis")
    (description "description")
    (license license:epl1.0)
    (home-page "https://leiningen.org")))

(define-public leininghen
  (package
    (name "leininghen")
    (version "2.11.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://codeberg.org/leiningen/leiningen.git")
               (commit version)))
        (file-name "leininghen")
        (sha256 (base32 "19q59dwj3hmn210l8zblkdb4ia17is2g3m0v1x7qmvavwpwyrl2g"))))
    (inputs (list openjdk21))
    (native-inputs (list leininghen-boot nss-certs))
    (build-system copy-build-system)
    (arguments
     `(#:modules ((guix build copy-build-system)
                  (guix build utils))
       #:phases
       (modify-phases %standard-phases
        (add-after 'patch-source-shebangs 'build
         (lambda* (#:key inputs outputs #:allow-other-keys)
           (let ((lein (which "lein-stable")))
             (copy-file lein "./lein-stable")
             (substitute* "./lein-stable"
               (("LEIN_HOME=.*$") "LEIN_HOME=lein-home;")
               (("LEIN_JAR=.*$") "LEIN_JAR=leininghen-standalone.jar;"))
             (chdir "./leiningen-core")
             (invoke "../lein-stable" "bootstrap")
             (chdir "..")))))))
    (synopsis "synopsis")
    (description "description")
    (license license:epl1.0)
    (home-page "https://leiningen.org")))

leininghen
; leininghen-boot

