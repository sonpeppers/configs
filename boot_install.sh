#!/bin/bash
# Paul Epperson

################################################################################
# Info about operating system (uname)
# -----------------------------------
# uname -o, --operating-system:  GNU/Linux
#       -s, --kernel-name:       Linux
#       -r, --kernel-release:    4.8.0-41-generic
#       -v, --kernel-version:    #44~16.04.1-Ubuntu SMP
#       -m, --machine:           x86_64
#       -p, --processor:         x86_64
#       -i, --hardware-platform: x86_64
#
# Info about machine (lscpu, sudo lshw)
# ------------------------------------------------
# sudo lshw | grep vendor:  Acer
#                  product: Aspire V7-582PG
#                           ...
#                           Intel(R) Core(TM) i5-4200U CPU @ 1.60 GHz
#                           ...
# lscpu: x86_64
#        Little Endian
#        4 CPU's
#        2 threads per core
#        32K L1 data cache
#        32K L1 instruction
#
# Useful commands for creating bootable partition (e.g. 1 per flash drive)
# ------------------------------------------------------------------------
# lsusb:  display usb info
# lsblk:  display device info
# umount: unmount a device (e.g. sudo umount /dev/sd??)
# dd:     zero out partition (e.g. if=/dev/zero of=/dev/sd??)
# mkfs:   assign device a filesystem (e.g. mkfs -t ext4 or ntfs)
# dd:     copy file to partition (e.g. sudo dd bs=4M if=*.iso of=/dev/sd??)
# sync:   use to enforce write completion of dd
#
# Example execution
# -----------------
# TODO
#
# Note: sudo do-release-upgrade is unbearably slow, just do clean installs

################################################################################
# Note: below commands are intended to run on completely new installation
# Note: apt-cache search <keyword> is useful for looking up packages by name
# Programs to manually update:
#   android-studio: https://developer.android.com/studio/index.html (bottom)
#   ardupilot: firmware.us.ardupilot.org/Tools/APMPlanner
#   anaconda: https://www.continuum.io/downloads
#   atom: https://atom.io (.deb)

################################################################################
# bare bones

# check for internet connectivity before proceeding
if [[ $(ping google.com -c 1) ]];
then
  echo No internet connectivity. Refusing to continue, exiting.
  exit 1
fi

# check for updates before proceeding
sudo apt-get --assume-yes update

# setup bare bone essentials
sudo apt-get --assume-yes install vim-gnome git

# .bashrc
# .bash_aliases
# .bash_profile
# .vimrc
# .gitconfig
# .ssh keys

################################################################################
# pretty

# clean up home directory
rm ~/examples.desktop
mkdir ~/devel

# background
wget http://cdn.wonderfulengineering.com/wp-content/uploads/2016/02/blue-wallpaper-25.jpg
sudo mv blue-wallpaper-25.jpg /usr/share/backgrounds/wallpaper.jpg
sudo chown $USER:$USER ~/.config/dconf -R
chmod u+w ~/.config/dconf -R
gsettings set org.gnome.desktop.background picture-uri /usr/share/backgrounds/wallpaper.jpg

###############################################################################
# applications

# xmonad, dmenu, feh (for wallpaper)
sudo apt-get --assume-yes install xmonad suckless-tools feh
convert /usr/share/backgrounds/wallpaper.jpg -crop 2560x1500+0+0 /usr/share/backgrounds/wallpaper.jpg
feh --bg-scale /usr/share/backgrounds/wallpaper.jpg

# pip, anaconda, jupyter
sudo apt-get --assume-yes install python3-pip
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
sudo bash Anaconda3-4.3.1-Linux-x86_64.sh -b -p '/opt/anaconda3'
rm Anaconda-4.3.1-Linux-x86_64.sh
pip3 install jupyter

# npm, node
sudo apt-get --assume-yes install npm

# java, eclipse
# Note: use sudo update-alternatives --config javac to choose between versions
#       and set JAVA_HOME in /etc/environment to the path of the version chosen
sudo apt-get --assume-yes install default-jdk eclipse

# google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get --assume-yes install google-chrome-stable flashplugin-installer

# android studio
# Note: use a more up to date android studio if possible
sudo apt-get --assume-yes install android-sdk
wget https://dl.google.com/dl/android/studio/ide-zips/2.3.0.8/android-studio-ide-162.3764568-linux.zip
sudo unzip android-studio-ide-162.3764568-linux.zip -d /opt/
rm android-studio-ide-162.3764568-linux.zip
sudo apt-get --assume-yes install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
sudo ln -s /opt/android-studio/bin/studio.sh android
sudo mv android /usr/local/bin

# ros
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get --assume-yes install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get --assume-yes install python-rosinstall

# arduino
sudo apt-get --assume-yes install arduino arduino-core

# atom
wget https://atom.io/download/deb
sudo dpkg --install deb
rm deb

# ardupilot's apmplanner
wget http://firmware.us.ardupilot.org/Tools/APMPlanner/apm_planner_2.0.24_xenial64.deb
sudo dpkg -i apm_planner_2.0.24_xenial64.deb
sudo apt-get -f install
sudo dpkg -i apm_planner_2.0.24_xenial64.deb
rm apm_planner_2.0.24_xenial64.deb
sudo apt-get --purge remove modemmanager

# eagle
sudo apt-get install eagle
mkdir -p ~/devel/eagle/cam \
	 ~/devel/eagle/dru \
	 ~/devel/eagle/lbr \
	 ~/devel/eagle/projects/examples
	 ~/devel/eagle/scr \
	 ~/devel/eagle/ulp

# verilog
# TODO

# quartus
# TODO

# Qt
sudo apt-get --assume-yes install qt5-default qtdeclarative5-dev

# tesseract, 0MQ, ... (?)
# TODO

# miscellaneous
sudo apt-get --assume-yes install gparted gimp octave shutter
