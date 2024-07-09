(define-module (syd-guix packages prismlauncher)
  #:use-module (guix)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages java)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages compression)
  #:use-module (guix build-system cmake))

(define-public prismlauncher
  (package
    (name "prismlauncher")
    (version "8.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/PrismLauncher/PrismLauncher")
               (recursive? #t)
               (commit "8.4")))
        (sha256 (base32 "07ngh55rqxslrs3q1qlydxavxcc39dmxsgqnlv7xmn13ci1n5vsr"))))
    (build-system cmake-build-system)
    (arguments (list #:build-type "Release"))
    (home-page "")
    (synopsis "A Minecraft launcher")
    (description "An Open Source Minecraft launcher with the ability to manage
multiple instances, accounts and mods. Focused on user freedom
and free redistributability.")
    (license license:gpl3)
    (native-inputs (list ecm qtbase qt5compat ninja extra-cmake-modules zlib
                         libxkbcommon vulkan-headers pkg-config
                         `(,openjdk17 "jdk") mesa))))

