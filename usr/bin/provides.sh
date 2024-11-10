#!/bin/busybox ash
. /etc/init.d/tc-functions
useBusybox

TARGET="$1"
[ -z "$TARGET" ] && exit 1

TCEDIR="/etc/sysconfig/tcedir"
DB="provides.db"

getMirror
cd "$TCEDIR"
if [ ! -f "$TCEDIR"/"$DB" ]; then
  pcpget -O "$TCEDIR"/"$DB".gz "$MIRROR"/"$DB".gz
  gunzip "$TCEDIR"/"$DB".gz
fi
cd - > /dev/null

awk 'BEGIN {FS="\n";RS=""} /'${TARGET}'/{print $1}' "$TCEDIR"/"$DB"
chmod g+rw "$TCEDIR"/"$DB"
