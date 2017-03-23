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
#   0MQ: http://zeromq.org/intro:get-the-software

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
sudo apt-get --assume-yes install vim-gnome git gitk
sudo apt-get --assume-yes install zsh csh ksh ash curl expect unzip wget
sudo apt-get --assume-yes install build-essential cmake autotools-dev pkg-config
printf "\n\n\n" | ssh-keygen -t rsa

# takeout online search
echo '[Desktop Entry]' >> disable_onlinesearch.desktop
echo 'Name=Disable Search' >> disable_onlinesearch.desktop
echo 'Exec=/bin/bash -c "gsettings set com.canonical.Unity.Lenses remote-content-search 'none'"' >> disable_onlinesearch.desktop
echo 'Type=Application' >> disable_onlinesearch.desktop
sudo mv disable_onlinesearch.desktop /etc/xdg/autostart
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop

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
echo 'gsettings set org.gnome.desktop.background picture-uri /usr/share/backgrounds/wallpaper.jpg' >> setBackground.sh
echo 'feh --bg-scale /usr/share/backgrounds/wallpaper.jpg' >> setBackground.sh
chmod 644 setBackground.sh
sudo mv setBackground.sh /etc/profile.d

# pip, anaconda, jupyter
sudo apt-get --assume-yes install python-pip python3-pip
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
sudo bash Anaconda3-4.3.1-Linux-x86_64.sh -b -p '/opt/anaconda3'
rm Anaconda-4.3.1-Linux-x86_64.sh
pip3 install jupyter

# atom
wget https://atom.io/download/deb
sudo dpkg --install deb
rm deb

# node, express, angular, mongodb
sudo apt-get --assume-yes install npm
npm config set prefix /opt
sudo npm install mongodb -g
sudo npm install express -g
sudo npm install angular -g
curl https://install.meteor.com | /bin/sh

# java, eclipse, ant
# Note: use sudo update-alternatives --config javac to choose between versions
#       and set JAVA_HOME in /etc/environment to the path of the version chosen
sudo apt-get --assume-yes install default-jdk eclipse ant

# doxygen
sudo apt-get --assume-yes install doxygen

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

# apmplanner
wget http://firmware.us.ardupilot.org/Tools/APMPlanner/apm_planner_2.0.24_xenial64.deb
sudo dpkg -i apm_planner_2.0.24_xenial64.deb
sudo apt-get -f --assume-yes install
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

# Qt, GTK3
sudo apt-get --assume-yes install qt5-default qtdeclarative5-dev qtcreator
sudo apt-get --assume-yes install libgtk-3-dev

# tesseract
sudo apt-get --assume-yes install tesseract-ocr

# OpenCV (shotgun approach)
# see http://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/
# see https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh
sudo apt-get --assume-yes install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get --assume-yes install lbavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
sudo apt-get --assume-yes install libgtk-3-dev libatlas-base-dev gfortran
sudo apt-get --assume-yes install libgtkglext1-dev libvtk6-dev zlib1g-dev libjpeg-dev libwebp-dev libpng-dev \
	     			  libopenexr-dev libgdal-dev libdc1394-22-dev libtheora-dev libvorbis-dev \
				  libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev \
				  libopencore-amrwb-dev libv4l-dev libxine2-dev \
				  libtbb-dev libeigen3-dev
wget https://github.com/opencv/opencv/archive/3.2.0.zip
unzip 3.2.0.zip
rm 3.2.0.zip
sudo mv opencv-3.2.0 /opt/OpenCV
sudo mkdir /opt/OpenCV/build
pushd /opt/OpenCV/build
sudo cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON ..
sudo make -j4
sudo make install
sudo ldconfig
popd

# 0MQ
sudo apt-get --assume-yes install libtool pkg-config build-essential autoconf uuid-dev e2fsprogs
wget https://github.com/zeromq/libzmq/releases/download/v4.2.1/zeromq-4.2.1.tar.gz
tar -xvf zeromq-4.2.1.tar.gz
rm zeromq-4.2.1.tar.gz
sudo mv zeromq-4.2.1 /opt
pushd /opt/zeromq-4.2.1
./configure
make
sudo make install
popd
sudo ldconfig

# samba
sudo apt-get --assume-yes install samba samba-common python-glade2 system-config-samba

# skype
sudo --assume-yes add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo dpkg --add-architecture i386
sudo apt-get --assume-yes update && sudo apt-get --assume-yes install skype

# miscellaneous
sudo apt-get --assume-yes install gparted virtualbox \
	     			  octave \
				  gimp audacity \
				  shutter recordmydesktop gtk-recordmydesktop

##########
# clean up
sudo apt-get -assuem-yes autoremove
