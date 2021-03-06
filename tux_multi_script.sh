#!/bin/bash
##DATE=`/bin/date '+%d%m'`
###UPGRADE DIST & DEL STEAM-RUNTIME###
function dist_upgrade {
    if [ -e "/etc/manjaro-release" ]; then
        sudo yaourt -Syua
    elif [ -e "/etc/arch-release" ]; then
        sudo pacman -Syu
    elif [ -e "/etc/debian_version" ]; then
        sudo apt-get -fy install
        sudo -- sh -c 'apt-get clean; apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y'
        sudo dpkg --configure -a
    fi
}
function dist_upgrade_adv {
    if [ -e "/etc/manjaro-release" ]; then
        sudo pacman -Sc
        sudo pacman -Syyu
    elif [ -e "/etc/arch-release" ]; then
        sudo pacman -Sc
        sudo pacman -Syyu
    elif [ -e "/etc/debian_version" ]; then
        sudo rm -rf /var/lib/apt/lists/*
        sudo -- sh -c 'apt-get clean; apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y'
        sudo dpkg --configure -a
        dpkg -l | awk '/^rc/ {print $2}' | xargs sudo dpkg --purge
   fi
}
function kernel_upg {
    if [ -e "/etc/manjaro-release" ]; then
        sudo mkinitcpio -P
    elif [ -e "/etc/arch-release" ]; then
        sudo mkinitcpio -P
    elif [ -e "/etc/debian_version" ]; then
        sudo update-initramfs -c -k all      
   fi
        sudo update-grub
}
function del_steamruntime {
    if [ -e "/etc/debian_version" ]; then
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.*
        rm ~/.steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgpg-error.so.*
    fi
}
###STEAM FIX###
function fix_dumps {
    sudo rm -rf /tmp/dumps
    sudo mkdir /tmp/dumps
    sudo chmod 000 /tmp/dumps
    sudo ln -s /dev/null /tmp/dumps
}
function fix_library {
    [ ! -d /home/SteamLibrary ] && sudo mkdir /home/SteamLibrary
    sudo chown -R $USER:$USER /home/SteamLibrary
    sudo chmod -R 777 /home/SteamLibrary
}
function del_steam {
    if [ -e "/etc/manjaro-release" ]; then
        sudo pacman -R steam-native steam-manjaro
    elif [ -e "/etc/arch-release" ]; then
        sudo pacman -R steam steam-native-runtime
    elif [ -e "/etc/debian_version" ]; then
        sudo apt-get purge steam:i386
    fi
}
###AIMTUX FIX###
function fix_at {
    [ ! -d /home/at ] && sudo mkdir /home/at
    sudo chmod 777 /home/at
    [ -d /tmp/AimTux* ] && sudo rm -rf /tmp/AimTux*
    [ -f /tmp/master* ] && sudo rm -f /tmp/master*
    [ -f /tmp/v1.0* ] && sudo rm -f /tmp/v1.0*
    [ -f /tmp/faceit* ] && sudo rm -f /tmp/faceit*
    [ -f /tmp/Fuzion* ] && sudo rm -f /tmp/Fuzion*
}
function fix_atcfg {
    [ ! -d /home/$USER/.config/AimTux ] && sudo mkdir /home/$USER/.config/AimTux
    [ ! -d /home/$USER/.config/AimTuxGH ] && sudo mkdir /home/$USER/.config/AimTuxGH
    sudo chown -R $USER:$USER /home/$USER/.config/AimTux*
    sudo chmod -R 700 /home/$USER/.config/AimTux*
    #FUZION
    [ ! -d /home/$USER/.config/Fuzion ] && sudo mkdir /home/$USER/.config/Fuzion
    [ ! -d /home/$USER/.config/FuzionGH ] && sudo mkdir /home/$USER/.config/FuzionGH
    sudo chown -R $USER:$USER /home/$USER/.config/Fuzion*    
    sudo chmod -R 700 /home/$USER/.config/Fuzion*
}
###CONFIGS###
function download_atcfg {
    cd /tmp
    [ -d /tmp/ATCFG ] && sudo rm -rf ATCFG
    [ -d /tmp/atconfigs ] && sudo rm -rf atconfigs
    git clone https://github.com/voltagegg/ATCFG
    #git clone https://github.com/McSwaggens/atconfigs && mv atconfigs ATCFG/McSwaggens_configs
    #git clone https://github.com/kvdrrrrr/atconfigs && mv atconfigs ATCFG/kvdrrrrr_configs
}
function upload_atcfg {
    cd /tmp
    [ -d /tmp/ATCFG ] && sudo rm -rf ATCFG
    [ -d /tmp/atconfigs ] && sudo rm -rf atconfigs
    git clone https://github.com/voltagegg/ATCFG
    cp -ar /home/$USER/.config/AimTux/* /tmp/ATCFG/configs/
    cd /tmp/ATCFG
    git init
    git add .
    git commit -a -m 'update configs'
    git push -u origin master 
}    
###EXEC FUNCTION###
del_steamruntime
clear
fix_dumps
fix_library
fix_atcfg
###MENU###
function menu {
clear
echo -e "\t\t\tМеню скрипта\n"
echo -e "\t1. Установка новой версии AimTux в (/home/at/am_new)"
echo -e "\t2. Установка старой версии AimTux в (/home/at/am_stable)"
echo -e "\t3. Установка FACEIT версии AimTux в (/home/at/am_faceit)"
echo -e "\t4. Установка FUZION версии AimTux в (/home/at/am_fuzion)"
echo -e "\t5. Удаление всех версий AimTux в (/home/at/*)\n"
echo -e "\t6. Установка конфигов AimTux"
echo -e "\t7. Удаление всех конфигов AimTux\n"
echo -e "\t8. Полное обновление системы Ubuntu/Debian/Arch"
echo -e "\t9. Установить требуемые пакеты для AimTux"
echo -e "\t0. Обновление компилятора G++ для Ubuntu/Debian на более новый"
echo -e "\tu. Очистка кэша обновлений и старой конфигурации системы"
echo -e "\tk. Обновление модулей ядра и загрузчика системы\n"
echo -e "\tf. Fixed dumps Steam folder"
echo -e "\tg. Clone my cfg to github"
echo -e "\to. Other tweaks for home"
echo -e "\tD. Deletion Steam"
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
     1)
            echo "Compiling AimTux new version..."
            fix_at
            download_atcfg
            [ -d /home/at/am_new ] && sudo rm -rf /home/at/am_new            
            git clone --recursive https://github.com/AimTuxOfficial/AimTux
            mv /tmp/AimTux /home/at/am_new
            cd /home/at/am_new
            cmake .
            make -j 4
            sudo cp -a /tmp/ATCFG/launcher /home/at/am_new/
            sudo chmod 700 launcher
            echo "Finished compiling AimTux new version!"
            ;;
     2)
            echo "Compiling AimTux stable version..."
            fix_at
            download_atcfg
            [ -d /home/at/am_stable ] && sudo rm -rf /home/at/am_stable
            wget https://github.com/AimTuxOfficial/AimTux/archive/v1.0.zip && unzip v1.0.zip
            mv /tmp/AimTux-1.0 /home/at/am_stable
            cd /home/at/am_stable
            cmake .
            make -j 4
            sudo cp -a /tmp/ATCFG/launcher /home/at/am_stable/
            sudo chmod 700 launcher
            echo "Finished compiling AimTux stable version..."
            ;;
     3)
            echo "Compiling AimTux FACEIT version..."
            fix_at
            download_atcfg
            [ -d /home/at/am_faceit ] && sudo rm -rf /home/at/am_faceit
            git clone --recursive -b faceit https://github.com/AimTuxOfficial/AimTux
            mv /tmp/AimTux /home/at/am_faceit
            cd /home/at/am_faceit
            cmake .
            make -j 4
            sudo cp -a /tmp/ATCFG/launcher /home/at/am_faceit/
            sudo chmod 700 launcher
            echo "Finished compiling AimTux FACEIT version!"
            ;;
     4)
            echo "Compiling AimTux FUZION version..."
            fix_at
            #download_atcfg
            [ -d /home/at/am_fuzion ] && sudo rm -rf /home/at/am_fuzion
            git clone --recursive https://github.com/LWSS/Fuzion
            mv /tmp/Fuzion /home/at/am_fuzion
            cd /home/at/am_fuzion
            ./build
            echo "Finished compiling AimTux FUZION version!"
            ;;    
     5)
            sudo rm -rf /home/at/*
            echo "Finished deletion AimTux!"
            ;;
     6)
            echo "Install Configs..."
            download_atcfg
            sudo cp -ar /tmp/ATCFG/configs/* /home/$USER/.config/AimTux/
            #other configs
            #sudo cp -ar /tmp/ATCFG/McSwaggens_configs/configs/* /home/$USER/.config/AimTux/
            #sudo cp -ar /tmp/ATCFG/kvdrrrrr_configs/* /home/$USER/.config/AimTux/
            echo "Finished install configs!"
            ;;
     7)
            sudo rm -rf /home/$USER/.config/AimTux*
            sudo rm -rf /home/$USER/.config/Fuzion*
            echo "Finished deletion configs!"
            ;;
     8)
            dist_upgrade
            echo "Finished upgrade system!"
            ;;
     9)
            if [ -e "/etc/manjaro-release" ]; then
                sudo pacman -Syu cmake gdb git sdl2 xdotool lua patchelf
            elif [ -e "/etc/arch-release" ]; then
                sudo pacman -Syu base-devel cmake gdb git sdl2 xdotool lua patchelf
            elif [ -e "/etc/debian_version" ]; then
                sudo apt-get update && sudo apt-get install -y cmake g++ gdb git libsdl2-dev zlib1g-dev libxdo-dev liblua5.3 patchelf
            fi
            echo "Finished pre-install packages!"
            ;;
     0)     
            sudo apt-get update
            sudo apt-get install gcc build-essential -y
            sudo add-apt-repository ppa:ubuntu-toolchain-r/test
            sudo apt-get update
            sudo apt-get install gcc-6 g++-6
            sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6
            ;;
     u)
            dist_upgrade_adv
            ;;
     k)
            kernel_upg
            ;;
     f)
            fix_dumps
            echo "Finished fixed dumps Steam!"
            ;;
     g)
            fix_atcfg
            upload_atcfg
            ;;
     o)
            [ ! -d /home/SOFT ] && sudo mkdir /home/SOFT
            sudo chmod -R 777 /home/SOFT
            echo "Finished other tweaks!"
            ;;
     D)     
            del_steam
            sudo rm -rf /home/$USER/Steam && sudo rm -rf /home/$USER/.steam
            echo "Finished deletion Steam!"
            ;;
     *)
            echo -en "\n\t\tНужно выбрать раздел!"
            ;;
        esac
    echo -en "\n\n\t\tНажмите любую клавишу для продолжения"
    read -n 1 line
    done
clear
