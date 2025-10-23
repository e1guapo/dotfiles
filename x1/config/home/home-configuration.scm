;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services dotfiles))
             (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "meld"
                                            "nmap"
                                            "keepassxc"
                                            "flameshot"
                                            "imagemagick"
                                            "python-virtualenv"
                                            "cifs-utils"
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
                                            "vim-full"
                                            "inotify-tools"
                                            "xclip"
                                            "make"
                                            "vim"
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
  (services (append (list (service home-bash-service-type
                          (home-bash-configuration
                           (aliases '(("alert" . "notify-send --urgency=low -i \"$([ $? = 0 ] && echo terminal || echo error)\" \"$(history|tail -n1|sed -e '\\''s/^\\s*[0-9]\\+\\s*//;s/[;&|]\\s*alert$//'\\'')\"")
                                      ("claude" . "npx @anthropic-ai/claude-code")
                                      ("codex" . "npx @openai/codex@latest")
                                      ("egrep" . "egrep --color=auto")
                                      ("fgrep" . "fgrep --color=auto")
                                      ("ghidra" . "/opt/ghidra_11.3.2_PUBLIC/ghidraRun")
                                      ("grep" . "grep --color=auto")
                                      ("l" . "ls -CF")
                                      ("la" . "ls -A")
                                      ("ll" . "ls -alF")
                                      ("ls" . "ls --color=auto"))))))
           %base-home-services)

            (service home-dotfiles-service-type
                     (home-dotfiles-configuration
                       (directories '("../../files"))))))
