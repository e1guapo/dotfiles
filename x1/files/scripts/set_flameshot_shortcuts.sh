#!/bin/sh
# Ensure Xfce keyboard shortcuts launch Flameshot with the absolute binary path.

set -eu

XFCONF_QUERY=$(command -v xfconf-query || true)
if [ -z "$XFCONF_QUERY" ]; then
    printf 'set_flameshot_shortcuts: xfconf-query not found; skipping\n' >&2
    exit 0
fi

FLAMESHOT_BIN=${FLAMESHOT_BIN:-$(command -v flameshot || true)}

if [ -z "$FLAMESHOT_BIN" ] || [ ! -x "$FLAMESHOT_BIN" ]; then
    printf 'set_flameshot_shortcuts: flameshot binary not found; skipping\n' >&2
    exit 0
fi

set_binding() {
    prop=$1
    value=$2

    for attempt in 1 2 3 4 5; do
        if "$XFCONF_QUERY" -c xfce4-keyboard-shortcuts -p "$prop" >/dev/null 2>&1; then
            if "$XFCONF_QUERY" -c xfce4-keyboard-shortcuts -p "$prop" -t string -s "$value"; then
                return 0
            fi
        else
            if "$XFCONF_QUERY" -c xfce4-keyboard-shortcuts -p "$prop" -n -t string -s "$value"; then
                return 0
            fi
        fi
        sleep 1
    done

    printf 'set_flameshot_shortcuts: failed to set %s after retries\n' "$prop" >&2
    return 1
}

set_binding '/commands/custom/Print' "${FLAMESHOT_BIN} gui"
set_binding '/commands/custom/<Alt>Print' "${FLAMESHOT_BIN} screen"
set_binding '/commands/custom/<Shift>Print' "${FLAMESHOT_BIN} full"

exit 0
