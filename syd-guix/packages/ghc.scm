(define-module (syd-guix packages ghc)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix build-system haskell)
  #:use-module (guix packages))

(define-public ghc-lambda
  (package
    (name "ghc-lambda")
    (version "0.1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (hackage-uri "lambda" version))
       (sha256
        (base32 "0311fk40119h9fclhrmv1kpj3gm0xqiq1jb0dgbwc69h942hnklv"))))
    (build-system haskell-build-system)
    (properties '((upstream-name . "lambda")))
    (home-page "https://github.com/UnaryPlus/lambda")
    (synopsis
     "Interpreters for lambda calculus, calculus of constructions, and more")
    (description
     "This package provides a collection of interpreters, type checkers, and REPLs
implemented in Haskell.  Currently, the following languages are supported: . *
Untyped lambda calculus * SK combinator calculus * System F * Hindley-Milner
type system * Calculus of constructions .  You can access the different REPLs by
passing an argument to the executable: \"lambda\", \"sk\", \"systemf\", \"hm\", or
\"coc\".  For more information, see the manual below.")
    (license license:expat)))

