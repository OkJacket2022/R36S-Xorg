#!/bin/bash

progdir=$(dirname "$(realpath "$0")")
line="--------------------------------------------------------------------------------"

printf "\033c"

echo $line
echo "Starting XFCE installation..."
echo "Please make sure you are connected to the internet during the installation."
echo "Please ensure that the device is connected to a power source or has sufficient battery."
echo "The installation may take a while."
echo "The installation will start in 10 seconds."
echo $line

for i in {1..10}; do
    echo -n "."
    sleep 1
done
echo "Updating package list..."
sudo apt update
echo $line
echo "Installing Xorg..."
sudo apt install xorg -y
echo $line
echo "Installing XFCE..."
# Change here to use other desktop environment
sudo apt-get install --no-install-recommends xfce4 -y
echo $line

echo "Installing display driver..."
sudo cp $progdir/files/driver/mali_drv.so /usr/lib/xorg/modules/drivers/
sudo cp $progdir/files/driver/99-mali.conf /etc/X11/xorg.conf.d/
sudo cp $progdir/files/driver/99-mali.conf /usr/share/X11/xorg.conf.d/
echo "Driver installed successfully."
echo $line

echo "Installing OnBoard keyboard..."
sudo apt install onboard -y
echo "Installing Qjoypad..."
sudo apt install qjoypad -y
echo "Installing Firefox..."
sudo apt install firefox -y
echo "Installing Xterm..."
sudo apt install xterm -y
echo "Installing htop..."
sudo apt install htop -y
echo $line

echo "Copying configuration files..."
cp -r $progdir/files/.config/ $HOME/
cp -r $progdir/files/.qjoypad3/ $HOME/
cp -r $progdir/files/.mozilla/ $HOME/

echo "Creating 2GB swap file..."

# create a 2gb file using dd at /roms/swapfile, test if file already exists
if [ -f $progdir/swapfile ]; then
# check if swap is enabled and on fstab
    echo "Swap file already exists."
    sudo chmod 600 $progdir/swapfile
    sudo swapon $progdir/swapfile
    # grep -qxF "$progdir/swapfile none swap sw 0 0" /etc/fstab || echo "$progdir/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

else
# create swap file
    sudo dd if=/dev/zero of=$progdir/swapfile bs=1024 count=2097152 status=progress 
    sudo chmod 600 $progdir/swapfile
    sudo mkswap $progdir/swapfile
    # echo "$progdir/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
    sudo swapon $progdir/swapfile
fi

echo "Swap file created successfully."
echo $line 
echo "Installation complete."
echo "You may start XFCE by opening LAUNCH-XFCE in the tools menu."

sleep 3
echo "System will reboot in 10 seconds..."
sleep 10
reboot