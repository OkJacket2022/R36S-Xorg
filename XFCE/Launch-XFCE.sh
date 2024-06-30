#!/bin/bash

progdir=$(dirname "$(realpath "$0")")
CUR_TTY=/dev/tty0
export TERM=linux
sudo chmod 666 $CUR_TTY
printf "\033c" > $CUR_TTY

echo "Starting XFCE."  > $CUR_TTY
sudo swapon $progdir/swapfile
pulseaudio --start
startx /usr/bin/xfce4-session -- :1 vt1 > $CUR_TTY 2>&1
sudo swapoff -a
echo "Exiting ..." > $CUR_TTY