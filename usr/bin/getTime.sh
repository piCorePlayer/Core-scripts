#!/bin/busybox ash
# bmarkus - 26/02/2014

NTPOPTS=""
if [ -f /etc/sysconfig/ntpserver ]; then
    for IP in $(cat /etc/sysconfig/ntpserver); do
        NTPOPTS="${NTPOPTS} -p ${IP}"
    done
fi

/usr/sbin/ntpd -q ${NTPOPTS}
