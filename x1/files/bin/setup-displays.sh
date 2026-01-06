#!/usr/bin/env bash
set -euo pipefail

INTERNAL="eDP-1"
TARGET_MODE="3840x1600"
TARGET_RATE="60"

XR=$(xrandr --query)

# Pick the first connected MST sink (DP-*-*)
EXTERNAL=$(printf "%s\n" "$XR" | awk '/^DP-[0-9]+-[0-9]+ connected/ {print $1; exit}')
[ -n "${EXTERNAL:-}" ] || exit 0

# Extract geometry token like 2880x1800+0+0 from a connector line
geo_from_line() {
  awk '{
    for (i=1;i<=NF;i++)
      if ($i ~ /^[0-9]+x[0-9]+\+[0-9]+\+[0-9]+$/) { print $i; exit }
  }'
}

ILINE=$(printf "%s\n" "$XR" | awk -v o="$INTERNAL" '$1==o {print; exit}')
ELINE=$(printf "%s\n" "$XR" | awk -v o="$EXTERNAL" '$1==o {print; exit}')

[ -n "${ILINE:-}" ] || exit 0
[ -n "${ELINE:-}" ] || exit 0

IGEO=$(printf "%s\n" "$ILINE" | geo_from_line)
EGEO=$(printf "%s\n" "$ELINE" | geo_from_line)

# If external is not enabled (no geometry), we must configure it.
if [ -z "${EGEO:-}" ]; then
  NEEDS_CONFIG=1
else
  # Compute desired external position: right-of internal
  IW=${IGEO%%x*}
  REST=${IGEO#*x}
  IH=${REST%%+*}
  REST=${REST#*+}
  IX=${REST%%+*}
  IY=${REST#*+}

  DX=$((IX + IW))
  DY=$IY
  WANT_GEO="${TARGET_MODE}+${DX}+${DY}"

  if [ "$EGEO" = "$WANT_GEO" ]; then
    # Already correct — do absolutely nothing (prevents MST flicker on i3 reload).
    exit 0
  fi
  NEEDS_CONFIG=1
fi

# Only below here do we touch outputs.
# Keep changes minimal; avoid toggling outputs off unless absolutely necessary.
# Ensure internal stays primary (no mode change unless you want one).
xrandr --output "$INTERNAL" --primary

# Configure external to desired mode+position.
# (Setting the same mode repeatedly is avoided by the early exit above.)
IW=${IGEO%%x*}
REST=${IGEO#*x}
REST=${REST#*+}
IX=${REST%%+*}
IY=${REST#*+}
DX=$((IX + IW))
DY=$IY

xrandr --output "$EXTERNAL" --mode "$TARGET_MODE" --rate "$TARGET_RATE" --pos "${DX}x${DY}"
