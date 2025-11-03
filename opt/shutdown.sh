#!/bin/busybox ash
. /etc/init.d/tc-functions
useBusybox
# put user shutdown commands here

ACTION="$1"
case $ACTION in
	reboot);;
	shutdown);;
	*);;
esac

if [ -x /usr/local/etc/init.d/slimserver ]; then
	PID=$(pidof slimserver.pl)
	if [ -n "$PID" ]; then
		sudo /usr/local/etc/init.d/slimserver stop
	fi
fi

# If no backup of home was done then loop through valid users to clean up.
if [ ! -e /tmp/backup_done ] || ! grep -q "^home" /opt/.filetool.lst; then
  awk 'BEGIN { FS=":" }  $3 >= 1000 && $1 != "nobody" { print $1 }' /etc/passwd > /tmp/users
  while read U; do
    while read F; do
      # don't do rm -rf /home/tc/
      if [ -n "$F" ]; then
        TARGET="/home/${U}/$F"
        if [ -d "$TARGET" ]; then
          rm -rf "$TARGET"
        else
          if [ -f "$TARGET" ]; then
            rm -f "$TARGET"
          fi
        fi
      fi
    done < /opt/.xfiletool.lst
  done < /tmp/users
fi
