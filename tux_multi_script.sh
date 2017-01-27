#!/bin/bash
##DATE=`/bin/date '+%d%m'`
###UPGRADE OS & DEL STEAM-RUNTIME###
function arch_upgrade {
    if [ -e "/etc/manjaro-release" ]; then
        sudo pacman -Syu
    fi
    if [ -e "/etc/arch-release" ]; then
        sudo pacman -Syu
    fi
}
function deb_upgrade {
    if [ -e "/etc/debian_version" ]; then
        sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -fy &&
        sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean
    fi
}
function del_steamruntime {
    if [ -e "/etc/debian_version" ]; then
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.*
    fi
}
###STEAM FIX###
function fix_dumps {
    [ ! -d /tmp/dumps ] && sudo mkdir /tmp/dumps
    sudo rm -rf /tmp/dumps/*
    sudo chmod 600 /tmp/dumps
}
function fix_library {
    [ ! -d /home/SteamLibrary ] && sudo mkdir /home/SteamLibrary
    sudo chown -R $USER:$USER /home/SteamLibrary
    sudo chmod -R 777 /home/SteamLibrary
}
###AIMTUX FIX###
function fix_at {
    [ ! -d /home/at ] && sudo mkdir /home/at
    sudo chmod 777 /home/at
    [ -d /tmp/AimTux* ] && sudo rm -rf /tmp/AimTux*
    [ -f /tmp/master* ] && sudo rm /tmp/master*
    [ -f /tmp/v1.0* ] && sudo rm /tmp/v1.0*
    [ -f /tmp/faceit* ] && sudo rm /tmp/faceit*
}
function fix_atcfg {
    [ ! -d /home/$USER/.config/AimTux ] && sudo mkdir /home/$USER/.config/AimTux
    sudo chown -R $USER:$USER /home/$USER/.config/AimTux
    sudo chmod -R 777 /home/$USER/.config/AimTux
}
###EXEC FUNCTION###
del_steamruntime
clear
fix_library
###MENU###
function menu {
clear
echo
echo -e "\t\t\tМеню скрипта\n"
echo -e "\t1. Установка AimTux(new) новая версия"
echo -e "\t2. Установка AimTux(stable) старая версия"
echo -e "\t3. Установка AimTux(faceit) версия для FACEIT"
echo -e "\t4. Установка конфигов AimTux"
echo -e "\t5. Удаление конфигов AimTux"
echo -e "\t6. Очистка каталога(/home/at/) от AimTux"
echo -e "\t7. Полное обновление системы Ubuntu/Debian/Arch"
echo -e "\t8. Other tweaks for home"
echo -e "\t9. Fixed dumps Steam folder"
echo -e "\t10. Deletion Steam folder"
echo -e "\t0. Установка необходимых пакетов(для ПЕРВИЧНОЙ сборки)"
echo -e "\tq. Выход\n"
echo -en "\tВведите номер раздела: "
read option
}
while [ $? -ne 1 ]
    do
        menu
        case $option in
     q)
            break 
            ;;
     0)
            if [ -e "/etc/manjaro-release" ]; then
                sudo pacman -Syu base-devel cmake gdb git sdl2 xdotool
            fi
            if [ -e "/etc/arch-release" ]; then
                sudo pacman -Syu base-devel cmake gdb git sdl2 xdotool
            fi
            if [ -e "/etc/debian_version" ]; then
                sudo apt-get update
                sudo apt-get install -y cmake g++ gdb git libsdl2-dev zlib1g-dev libxdo-dev
            fi
            echo "Finished pre-install packages!"
            ;;
     1)
            echo "Compiling AimTux new version..."
            fix_at
            [ -d /home/at/am_new ] && sudo rm -rf /home/at/am_new
            cd /tmp
            git clone https://github.com/McSwaggens/AimTux
            mv /tmp/AimTux /home/at/am_new
            cd /home/at/am_new
            cmake .
            make -j 4
            echo "Finished compiling AimTux new version!"
            ;;
     2)
            echo "Compiling AimTux stable version..."
            fix_at
            [ -d /home/at/am_stable ] && sudo rm -rf /home/at/am_stable
            cd /tmp
            wget https://github.com/McSwaggens/AimTux/archive/v1.0.zip && unzip v1.0.zip
            mv /tmp/AimTux-1.0 /home/at/am_stable
            cd /home/at/am_stable
            cmake .
            make -j 4
            echo "Finished compiling AimTux stable version!"
            ;;
     3)
            echo "Compiling AimTux FACEIT version..."
            fix_at
            [ -d /home/at/am_faceit ] && sudo rm -rf /home/at/am_faceit
            cd /tmp
            wget https://github.com/McSwaggens/AimTux/archive/faceit.zip && unzip faceit.zip
            mv /tmp/AimTux-faceit /home/at/am_faceit
            cd /home/at/am_faceit
            cmake .
            make -j 4
            echo "Finished compiling AimTux FACEIT version!"
            ;;
     4)
            echo "Install Configs..."
            fix_atcfg
            cd /tmp
            [ -d /tmp/ATCFG ] && sudo rm -rf ATCFG
            git clone https://github.com/voltagegg/ATCFG
            sudo cp -ar /tmp/ATCFG/configs/* /home/$USER/.config/AimTux/
            [ -d /tmp/atconfigs ] && sudo rm -rf atconfigs
            git clone https://github.com/McSwaggens/atconfigs
            sudo cp -ar /tmp/atconfigs/configs/* /home/$USER/.config/AimTux/
            echo "Finished install configs!"
            ;;
     5)
            sudo rm -rf /home/$USER/.config/AimTux/*
            echo "Finished deletion configs!"
            ;;
     6)
            sudo rm -rf /home/at/*
            echo "Finished deletion AimTux!"
            ;;
     7)
            deb_upgrade
            arch_upgrade
            echo "Finished upgrade system!"
            ;;
     8)
            [ ! -d /home/SOFT ] && sudo mkdir /home/SOFT
            sudo chmod -R 777 /home/SOFT
            echo "Finished other tweaks!"
            ;;
     9)
            fix_dumps
            echo "Finished fixed dumps Steam!"
            ;;
     10)
            sudo rm -rf /home/$USER/Steam && sudo rm -rf /home/$USER/.steam
            echo "Finished deletion Steam folders!"
            ;;
     *)
            echo -en "\n\t\tНужно выбрать раздел!"
            ;;
        esac
    echo -en "\n\n\t\tНажмите любую клавишу для продолжения"
    read -n 1 line
    done
clear
