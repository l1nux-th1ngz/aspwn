#!/bin/bash

# Update package lists
sudo apt-get update

# Install the required packages
sudo apt-get -y install xorg xserver-xorg xbacklight xbindkeys xvkbd xinput build-essential make git policykit-1-gnome
sudo apt-get -y install network-manager network-manager-gnome pamixer nemo gvfs file-roller lxappearance dialog mtools
sudo apt-get -y install dosfstools avahi-daemon gvfs-backends gnome-power-manager net-tools
sudo apt-get -y install pulseaudio pavucontrol pamixer pulsemixer maim udiskie udisks2 exa scrot
sudo apt-get -y install rofi uxplay libnotify-bin xdotool unzip zip libnotify-dev geany-plugins
sudo apt-get -y install geany vlc kitty alacritty lolcat rxvt-unicode zenity yad dex cmus arc-theme
sudo apt-get -y install ascii toilet toilet-fonts figlet wget curl sxhkd polybar suckless-tools
sudo apt-get -y install jq yq ffmpeg lz4 notepadqq dos2unix w3m gvfs-fuse wmctrl brightnessctl python3-pip
sudo apt-get -y install playerctl mstools mpc imagemagick p7zip-full cmake-extras smartmontools libjpeg-dev
sudo apt-get -y install autoconf automake lsd cava font-downloader font-manager font-manager-common procps
sudo apt-get -y install fontconfig fzf libsecret-1-0 thefuck util-linux gcc bc libxcb-xrm-dev libxkbcommon-x11-dev 
sudo apt-get -y install pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev fif0 libxkbcommon-dev xclip ttyoclock papirus-icon-theme
sudo apt-get -y install libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev 
sudo apt-get -y install ripgrep ffmpegthumbnailer exiftool mcomix fonts-recommended fonts-font-awesome fonts-terminus fonts-noto fonts-oxygen
sudo apt-get -y install build-essential git im libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev
sudo apt-get -y install libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev
sudo apt-get -y install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev 
sudo apt-get -y install libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev 
sudo apt-get -y install libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev
sudo apt-get -y install libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev
sudo apt-get -y install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev 
sudo apt-get -y install libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev
sudo apt-get -y install libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

# Create tools directory and change to it
mkdir ~/tools && cd ~/tools

# Install bspwm
git clone https://github.com/baskerville/bspwm.git
cd bspwm
make -j$(nproc)
sudo make install
cd ..

# Install sxhkd
git clone https://github.com/baskerville/sxhkd.git
cd sxhkd
make -j$(nproc)
sudo make install
cd ..

# Install polybar
git clone --recursive https://github.com/polybar/polybar
cd polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
cd ../../

# Install picom
git clone https://github.com/ibhagwan/picom.git
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
cd ..

# Configure fonts
if [[ -d "$fdir" ]]; then
    cp -rv $dir/fonts/* $fdir
else
    mkdir -p $fdir
    cp -rv $dir/fonts/* $fdir
fi

# Configure wallpaper
if [[ -d "~/Wallpapers" ]]; then
    cp -rv $dir/wallpapers/* ~/Wallpapers
else
    mkdir ~/Wallpapers
    cp -rv $dir/wallpapers/* ~/Wallpapers
fi
wal -nqi ~/Wallpapers/archkali.png
sudo wal -nqi ~/Wallpapers/archkali.png

# Configure configuration files
cp -rv $dir/.config/* ~/.config/
sudo cp -rv $dir/.config/* /root/.config/

# Configure scripts
cp -rv $dir/scripts/* ~/.local/bin/
sudo cp -rv $dir/scripts/* /usr/local/bin/
sudo chmod +x ~/.local/bin/*
sudo chmod +x /usr/local/bin/*

echo -e "\nEnvironment setup completed successfully!\nPlease restart your system for all changes to take effect.\n"
