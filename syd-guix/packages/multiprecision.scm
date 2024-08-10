(define-module (syd-guix packages multiprecision))

(define-public gmp-5.0
  (package
    (inherit gmp)
    (version "5.1.3")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/gmp/gmp-"
                                  version ".tar.xz"))
              (sha256
                (base32
                  "0wbhn3wih61vjcs94q531fipfvvzqfq2v4qr03rl3xaggyiyvqny"))))))

