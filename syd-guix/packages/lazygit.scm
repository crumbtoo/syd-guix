(define-module (syd-guix packages lazygit)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix build utils)
  #:use-module (gnu packages golang)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix)
  #:use-module (guix build-system go))

(define-public lazygit
  (package
    (name "lazygit")
    (version "0.41.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/jesseduffield/lazygit/archive/refs/tags/v"
             version ".tar.gz"))
       (sha256
        (base32 "1f4zlk726kj7ijnrmsg19a8wngmf2r1kzy4b26vy93sqafi6y5zj"))))
    (build-system go-build-system)
    (arguments
     (list
      #:install-source? #f
      #:tests? #f
      #:go go-1.20
      #:import-path "github.com/jesseduffield/lazygit"))
    (home-page "https://github.com/jesseduffield/lazygit")
    (synopsis "A simple terminal UI for git commands")
    (description "Lazygit is an interactive text-based interface for Git
written in Go.")
    (license license:expat)))

