#!/bin/bash

echo -e "starting the installation process"
sleep 1s

echo -e "installing required packages using pacman"
sleep 1s

sudo pacman -S git jq clash feh dunst i3-gaps automake make autoconf dbus-python i3blocks mpd ncmpcpp neovim rofi i3lock gnome-screenshot alacritty ttf-font-awesome playerctl
sleep 1s

git clone https://aur.archlinux.org/yay.git ~/yay 
cd ~/yay && makepkg -si
sleep 1s

echo -e "installing packages from aur using yay"
yay -S polybar cava picom-jonaburg-git conky-lua

echo -e "installation of packages done"
sleep 1s 
echo -e "fetching the gruvbox dotfiles from github"
sleep 1s

git clone --bare https://github.com/sourav2k/dotfiles.git -b i3-gaps-thefallnn $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

