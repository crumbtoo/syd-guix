;; make 'LCURS=-lncurses -ltinfo' 'LIBPATH=-L/usr/lib -L/usr/ccs/lib' \
;;  'LIBZ=-lz' 'LIBBZ2=-lbz2' 'CFLAGS=-g' 'CC=gcc' \
;;  'LDFLAGS=-L/usr/lib -L/usr/ccs/lib'

;; guix shell -v3 -C -F --link-profile coreutils -f heirloom-ng.scm

(define-module (guix-packager)
  #:use-module (guix)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix build gnu-build-system)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages c)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages text-editors)
  #:use-module (gnu packages base))

(define-public heirloom-ng
  (package
    (name "heirloom-ng")
    (version "git-temp")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "git://127.0.0.1/git/heirloom-ng")
              (commit "5d2623d7ad615835d9efb32eaff8ec284a381f2b")))
        ; (file-name (git-file-name name version))
        (sha256 (base32 "1c6ysfxhbzhrmcc6b0pwf8zknhq8nkrnxzs670z64x14b02yv9s5"))))
    (inputs (list gawk ncurses ncurses/tinfo gzip byacc flex bzip2 zlib ncurses
                  ed glibc-2.33 gcc-toolchain coreutils sed))
    (native-inputs (list coreutils))
    (build-system gnu-build-system)
    (arguments
      `(#:tests? #f
        #:make-flags
        (let ((out (assoc-ref %outputs "out")))
         (list
           (string-append "ROOT=" out)
           "SHELL=bash"
           "POSIX_SHELL=bash"
           "CC=gcc"
           "LCURS=-lncurses -ltinfo"
           "LIBPATH=-L/usr/lib -L/usr/ccs/lib"
           "LIBZ=-lz"
           "LIBBZ2=-lbz2"
           "LDFLAGS=-L/usr/lib -L/usr/ccs/lib"
           "LNS=ln -s"
           ;; /var/log/utmp does not exist in our build
           "TTYGRP="
           #; "CCSBIN=/usr/ucb"
           (string-append "DEFBIN=" out)))
         #:phases (modify-phases %standard-phases
                                 (delete 'configure))))
    (home-page "http://heirloom-ng.pindorama.dob.jp/")
    (synopsis "A collection of standard Unix utilities that is intended to
               provide maximum compatibility with traditional Unix while
               incorporating additional features necessary today. ")
    (description "A collection of standard Unix utilities that is intended to
                  provide maximum compatibility with traditional Unix while
                  incorporating additional features necessary today.  This fork
                  aims to replace the old set of patches used by Copacabana
                  Linux, by implementing tools that were lacking and enhancing
                  compatibility with newer operating systems.")
    (license license:gpl2+)))

;; This allows you to run guix shell -f guix-packager.scm.
;; Remove this line if you just want to define a package.
heirloom-ng

