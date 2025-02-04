#!/bin/bash

progdir=$(dirname "$(realpath "$0")")
CUR_TTY=/dev/tty0
export TERM=linux
sudo chmod 666 $CUR_TTY
printf "\033c" > $CUR_TTY

echo "Starting XFCE."  > $CUR_TTY
sudo swapon $progdir/swapfile
sudo mkdir /run/user/1002
sudo chown 1002 /run/user/1002/
pulseaudio --start
startx /usr/bin/startxfce4 -- :1 vt1 > $CUR_TTY 2>&1
sudo swapoff -a
echo "Exiting ..." > $CUR_TTY