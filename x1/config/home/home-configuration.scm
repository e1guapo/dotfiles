;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services dotfiles)
             (gnu home services shells)
             (gnu home services xdg))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "meld"

					    ;; DELETEME
					    "diffutils"
					    "coreutils"
					    "bash"
					    "opam"

                                            "nmap"
                                            "keepassxc"
                                            "flameshot"
                                            "imagemagick"
                                            "python-virtualenv"
                                            "cifs-utils"
					    "node"
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
                                            "glibc-locales"
                                            "xfce4-settings")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services (list (service home-bash-service-type
                           (home-bash-configuration
                            (bashrc (list (local-file "../../files/.bashrc" "bashrc")))
                            (bash-profile (list (local-file "../../files/.profile" "bash_profile")))
                            (bash-logout (list (local-file "../../files/.bash_logout" "bash_logout")))))
                  (service home-dotfiles-service-type
                           (home-dotfiles-configuration
                            (directories '("../../files"))
                            (excluded '("^\\.bashrc$" "^\\.profile$" "^\\.bash_logout$")))))))
