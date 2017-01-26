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
printf 'Select the version AimTux to install! 1)New; 2)Stable; 3)Faceit; 4)Install configs; 5)Cleaning configs; 6)Cleaning AimTux : '
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
          echo "FINISH"
          ;;
     2)
          echo "Эй! Это мой любимый серверный дистрибутив!"
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
          echo "Finished compiling AimTux for FACEIT"
          ;;
     4)
          echo ""
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
