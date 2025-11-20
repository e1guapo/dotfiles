# flatpak stuff
# Alias all flatpaks to their logical command names, but only if they're not already commands.
# tld.domain.AppName becomes the alias "appname"
# if "appname" is already used by another command then "tld.domain.AppName" is used instead.
# If both are used, nothing is aliased.
#alias_flatpak_exports() {
#    local item
#    for item in {${XDG_DATA_HOME:-$HOME/.local/share},/var/lib}/flatpak/exports/bin/*; do
#        [ -x "$item" ] || continue
#
#        local flatpak_short_alias="${item//*.}"
#        local flatpak_long_alias="${item//*\/}"
#
#        if [ ! "$(command -v "$flatpak_short_alias")" ]; then
#            alias "${flatpak_short_alias,,}"="$item"
#        elif [ ! "$(command -v "$flatpak_long_alias")" ]; then
#            alias "$flatpak_long_alias"="$item"
#        fi
#    done
#}
#alias_flatpak_exports
#export PATH="$PATH:~/.local/share/flatpak/exports/bin"
