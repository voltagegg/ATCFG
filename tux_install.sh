#!/bin/bash
##DATE=`/bin/date '+%d%m'`
###UPGRADE OS & DEL STEAM-RUNTIME###
if [ -e /etc/arch-release ]; then 
    sudo pacman -Syu
    sudo pacman -S base-devel cmake gdb git sdl2 xdotool
fi
if [ -e /etc/debian_version ]; then
    sudo apt-get update
    sudo apt-get install -y cmake g++ gdb git libsdl2-dev zlib1g-dev libxdo-dev
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.*
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
###CASE###
clear
printf 'Select the version AimTux to install or other function! 
AimTux menu: 1)New; 2)Stable; 3)Faceit; 
Config menu: 4)Install configs; 5)Clear configs;
Other menu:  6)Clear AimTux;
read BRANCH
case $BRANCH in
     1)
          echo "Compiling AimTux default..."
            [ -d /home/at/am_new ] && sudo rm -rf /home/at/am_new
            sudo rm master.*
            git clone https://github.com/McSwaggens/AimTux
            mv /tmp/AimTux /home/at/am_new
            cd /home/at/am_new
            cmake .
            make -j 4
          echo "Finished compiling AimTux!"
          ;;
     2)
          echo ""
          ;;
     3)
          echo "Compiling AimTux for FACEIT..."
            [ -f /tmp/faceit* ] && sudo rm faceit*
            [ -d /home/at/am_faceit ] && sudo rm -rf /home/at/am_faceit
            wget https://github.com/McSwaggens/AimTux/archive/faceit.zip && unzip faceit.zip
            mv /tmp/AimTux-faceit /home/at/am_faceit
            cd /home/at/am_faceit
            cmake .
            make -j 4
          echo "Finished compiling AimTux for FACEIT!"
          ;;
     4)
          echo "Install Configs..."
            [ -d /home/scripts ] && sudo chmod -R 777 /home/scripts
            [ ! -d /home/$USER/.config/AimTux ] && sudo mkdir /home/$USER/.config/AimTux
            sudo chown -R $USER:$USER /home/$USER/.config/AimTux
            sudo chmod -R 777 /home/$USER/.config/AimTux
            cd /tmp
            [ -d /tmp/ATCFG ] && sudo rm -rf ATCFG
            git clone https://github.com/voltagegg/ATCFG
            sudo cp -ar /tmp/ATCFG/configs/* /home/$USER/.config/AimTux/
            [ -d /tmp/atconfigs ] && sudo rm -rf atconfigs
            git clone https://github.com/McSwaggens/atconfigs
            sudo cp -ar /tmp/atconfigs/configs/* /home/$USER/.config/AimTux/
          echo "Done! If CSGO is already open, press the reload button!"
          ;;
     5)
          echo ""
          ;;
     6)
          echo ""
          ;;
     *)
          echo "Please enter a number!"
          ;;
esac
echo "Script finished the job!"
