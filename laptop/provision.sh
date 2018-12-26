#!/bin/bash


SYSTEM="base-devel git tlp"
sudo pacman -Sy --noconfirm --needed $SYSTEM

TOOLS="duplicity vim terminator powerline powerline-fonts"
APPS="thunderbird inkscape gimp chromium filezilla"
DEVELOP="docker jdk-openjdk code maven"

sudo pacman -Sy --noconfirm --needed $TOOLS $APPS $DEVELOP

USER_REPOS="enpass-bin google-chrome intellij-idea-ultimate-edition sublime-text-dev oh-my-zsh-git"
AUR_DIR="$HOME/git/aur"

for repo in $USER_REPOS; do
	repo_dir="$AUR_DIR/$repo"
	if [[ ! -e $repo_dir ]]; then
		git clone https://aur.archlinux.org/${repo}.git $repo_dir
		cd $repo_dir
		makepkg -sicr --noconfirm --needed
	fi
done

sudo pacman -Syu --noconfirm

#
# see https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_T450s
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Setting up environment
alias ll='ls -l'
alias la='ls -la'
alias g='git status'

sudo chsh -s /bin/zsh markus
archlinux-java set java-11-openjdk