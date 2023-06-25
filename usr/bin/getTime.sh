#!/bin/busybox ash
# bmarkus - 26/02/2014

[ -f /etc/sysconfig/ntpserver ] && NTPOPTS="-p $(cat /etc/sysconfig/ntpserver)" || NTPOPTS=""
/usr/sbin/ntpd -q $NTPOPTS
