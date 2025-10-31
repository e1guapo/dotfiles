;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services)
             (gnu home services dotfiles)
             (gnu home services shells)
             (gnu home services xdg))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "meld"

                        ;; uncomment to try with guix container
                        ;; "diffutils"
                        ;; "coreutils"
                        ;; "bash"

                        ;; RS BBN access
                        "keepassxc"

                        "tree"
                        "nmap"
                        "flameshot"
                        "imagemagick"
                        "python-virtualenv"
                        "cifs-utils"
                        "node"
                        "openjdk@23.0.2"
                        "git-lfs"
                        "gnupg"
                        "git"
                        "direnv"
                        "cmake"
                        "texlive"
                        "imhex-pattern-language"
                        "imhex"
                        "xss-lock"
                        "fontconfig"
                        "slirp4netns"
                        "tk"
                        "python"
                        "texlive-inconsolata-nerd-font"
                        "universal-ctags"
                        "curl"
                        "python-packaging"
                        "nss-certs"
                        "simg2img"
                        "opam"
                        "vim-full"
                        "inotify-tools"
                        "xclip"
                        "make"
                        "file"
                        "libbsd"
                        "libtool"
                        "libffi"
                        "xz"
                        "ncurses"
                        "sqlite"
                        "readline"
                        "bzip2"
                        "lbzip2"
                        "zlib"
                        "lzlib"
                        "openssl"
                        "pkg-config"
                        "libxcrypt"
                        "glibc-locales")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services (list (simple-service 'custom-env-vars
                                  home-environment-variables-service-type
                                  `(("PATH" . "/var/lib/flatpak/exports/bin:$PATH")
                                    ("PATH" . "$HOME/.local/share/flatpak/exports/bin:$PATH")
                                    ("PATH" . "$HOME/.local/bin:$PATH")
                                    ("PATH" . "$HOME/bin:$PATH")
                                    ("GDK_DPI_SCALE" . "1.25")))
                  (service home-bash-service-type
                           (home-bash-configuration
                            (bashrc (list (local-file "../../files/.bashrc" "bashrc")))
                            (bash-profile (list (local-file "../../files/.bash_profile" "bash_profile")))
                            (bash-logout (list (local-file "../../files/.bash_logout" "bash_logout")))))
                  (service home-dotfiles-service-type
                           (home-dotfiles-configuration
                            (directories '("../../files"))
                            (excluded '("^\\.bashrc$" "^\\.bash_logout$" "^\\.bash_profile$" "^\\.profile$")))))))
