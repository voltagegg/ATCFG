#!/bin/bash
##DATE=`/bin/date '+%d%m'`
###UPGRADE OS###
if [ -e /etc/arch-release ]; then 
    sudo pacman -Syu &&
    sudo pacman -S base-devel cmake gdb git sdl2 xdotool
fi
if [ -e /etc/debian_version ]; then 
        sudo apt-get update &&
        sudo apt-get install -y cmake g++ gdb git libsdl2-dev zlib1g-dev libxdo-dev
fi
###STEAM FIX###
[ ! -d /tmp/dumps ] && sudo mkdir /tmp/dumps
sudo rm -rf /tmp/dumps/*
sudo chmod 600 /tmp/dumps
[ ! -d /home/SteamLibrary ] && sudo mkdir /home/SteamLibrary
sudo chown -R $USER:$USER /home/SteamLibrary
sudo chmod -R 777 /home/SteamLibrary
###AIMTUX###
[ ! -d /home/at ] && sudo mkdir /home/at
sudo chmod 777 /home/at
[ ! -d /home/$USER/.config/AimTux ] && sudo mkdir /home/$USER/.config/AimTux
sudo chown -R $USER:$USER /home/$USER/.config/AimTux
sudo chmod -R 777 /home/$USER/.config/AimTux
###CLEAN INSTALL###
cd /tmp
[ -d /tmp/AimTux* ] && sudo rm -rf AimTux*
###FACEIT###
[ -f /tmp/faceit* ] && sudo rm faceit*
[ -d /home/at/am_faceit ] && sudo rm -rf /home/at/am_faceit
wget https://github.com/McSwaggens/AimTux/archive/faceit.zip && unzip faceit.zip
mv /tmp/AimTux-faceit /home/at/am_faceit
cd /home/at/am_faceit
cmake .
make -j 4
echo "FINISH"

