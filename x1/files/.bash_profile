# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.bash_completion" ] && [ -d "$HOME/.guix-profile/etc/bash_completion.d" ]; then
    for f in ~/.guix-profile/etc/bash_completion.d/*; do
        dest_link=".bash_completion/$(basename $f)"
        if [[ ! -L "$dest_link" && ! -e "$dest_link" ]]; then
            ln -s $f .bash_completion/$(basename $f);
        fi
    done
fi

if [ -f "$HOME/.local/share/../bin/env" ]; then
    . "$HOME/.local/share/../bin/env"
fi
