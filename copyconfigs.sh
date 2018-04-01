#! /bin/bash

function copy {
    sudo cp -r $1 $2
    sudo chown -R $USER $2
}

function installExtension {
    if [ ! -d $2 ]; then
        git clone $1 $2
    fi
}

#===================================EXTENSIONS==================================
installExtension https://github.com/AndresCidoncha/audio-switcher.git ~/.local/share/gnome-shell/extensions/audio-switcher@AndresCidoncha
installExtension https://github.com/zzrough/gs-extensions-drop-down-terminal.git ~/.local/share/gnome-shell/extensions/drop-down-terminal@zzrough
installExtension https://github.com/mpdeimos/gnome-shell-remove-dropdown-arrows.git ~/.local/share/gnome-shell/extensions/remove-dropdown-arrows@mpdeimos
installExtension https://github.com/zpydr/gnome-shell-extension-taskbar.git ~/.local/share/gnome-shell/extensions/taskbar@zpydr
installExtension https://github.com/phocean/TopIcons-plus.git ~/.local/share/gnome-shell/extensions/TopIconsPlus
#================================SCRIPTS========================================
if [ ! -d /usr/local/bin ]; then
    sudo mkdir /usr/local/bin
fi
sudo cp Scripts/* /usr/local/bin
sudo chmod +x /usr/local/bin/*
