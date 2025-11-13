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

(define flameshot-shortcuts-desktop
  (plain-file
   "set-flameshot-shortcuts.desktop"
   (string-append
    "[Desktop Entry]\n"
    "Type=Application\n"
    "Version=1.0\n"
    "Name=Set Flameshot Shortcuts\n"
    "Comment=Ensure PrintScreen bindings target Flameshot.\n"
    "Exec=sh -c '$HOME/scripts/set_flameshot_shortcuts.sh'\n"
    "X-GNOME-Autostart-enabled=true\n")))

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

                        "ranger"
                        "cloc"
                        "strace"
                        "tree"
                        "nmap"
                        "flameshot"
                        "imagemagick"
                        "python-virtualenv"
                        "cifs-utils"
                        "node"
                        "openjdk@23.0.2"
                        ;;"git-lfs" ;; uncomment when not broken (ruby-activesupport test failing)
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
                        "python-pip"
                        "python-packaging"
                        "texlive-inconsolata-nerd-font"
                        "universal-ctags"
                        "curl"
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
                                  (append '(("PATH" . "/var/lib/flatpak/exports/bin:$PATH")
                                            ("PATH" . "$HOME/.local/share/flatpak/exports/bin:$PATH")
                                            ("PATH" . "/opt/ghidra_11.4.2_PUBLIC:$PATH")
                                            ("PATH" . "$HOME/.local/bin:$PATH")
                                            ("PATH" . "$HOME/bin:$PATH"))
                                          '(("EDITOR" . "vim")
                                            ("HISTSIZE" . "10000")
                                            ;; don't put lines starting with space in the history.
                                            ;; See bash(1) for more options
                                            ("HISTCONTROL" . "ignorespace"))
                                          '(("XCURSOR_PATH" . "$HOME/.guix-home/profile/share/icons:/usr/share/icons:$HOME/.icons")
                                            ("XCURSOR_SIZE" . "48")
                                            ("XCURSOR_THEME" . "Adwaita")
                                            ("GDK_DPI_SCALE" . "1.25"))))
                  (service home-bash-service-type
                           (home-bash-configuration
                            (aliases '(
                                       ("claude" . "npx @anthropic-ai/claude-code")
                                       ("codex" . "npx @openai/codex@latest")
                                       ("ghidra" . "/opt/ghidra_11.3.2_PUBLIC/ghidraRun")
                                       ("l" . "ls -CF")
                                       ("la" . "ls -A")
                                       ("ll" . "ls -alF")))
                            (bashrc
                              (list (local-file "bash_config_files/base.bashrc")
                                    (local-file "bash_config_files/bash-prompt.bashrc")
                                    (local-file "bash_config_files/conda.bashrc")
                                    (local-file "bash_config_files/direnv.bashrc")
                                    (local-file "bash_config_files/flatpak.bashrc")
                                    (local-file "bash_config_files/ssh-agent.bashrc")
                                    (local-file "bash_config_files/uv.bashrc")))
                            (bash-profile (list (local-file "bash_config_files/bash_profile.bashrc")))
                            (bash-logout (list (local-file "bash_config_files/bash_logout.bashrc")))))
                  (service home-dotfiles-service-type
                           (home-dotfiles-configuration
                            (directories '("../../files"))
                            ;; We are explicit with the excluded list to remove all the .git stuff.
                            (excluded '(".*~" ".*\\.swp"))))
                  (simple-service 'flameshot-shortcuts-autostart
                                  home-xdg-configuration-files-service-type
                                  (list
                                   `("autostart/set-flameshot-shortcuts.desktop"
                                     ,flameshot-shortcuts-desktop))))))
