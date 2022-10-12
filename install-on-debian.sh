#!/usr/bin/env bash

# install git + z shell 
echo "Installing base programs (git, zsh)"
apt-get install git stow zsh 

echo "Set zsh as default shell"
chsh -s $(which zsh) $USER

# create folder and move into $HOME/src/$USER
config_folder=$HOME/src/github
mkdir -p $config_folder

pushd $config_folder
    # clone das-nix-os repo
    git clone https://github.com/mdupuis13/das-nix-os.git das-nix-os

    # clone dotfilez-dasboss-pc repo
    git clone https://github.com/mdupuis13/dotfiles.git .dotfiles
popd

























# ask to install X or not
echo -n "Install an X environment ? Y/n: "
read -r p install_x

case $install_x in
    [yY][eE][sS]|[yY])
        echo "Install X Window stuff is NOT ready, sorry :("
        # if YES run install-x-on-debian.sh
        ;;
    [nN][oO]|[nN])
        echo "Just install a terminal config"
        ;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
esac


# ask to install devenv
echo -n "Install your dev environment ? Y/n: "
read -r p install_dev_env

case $install_dev_env in
    [yY][eE][sS]|[yY])
         echo "Install dev-env stuff"
         # if YES clone repo and run universal-devenv/install.sh
         install_devenv
         ;;
    [nN][oO]|[nN])
        echo "Not installing dev-env stuff..."
        ;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
esac

function install_devenv() {
    pushd $base_src_folder
        # clone universal-devenv repo
        git clone https://github.com/mdupuis13/universal-devenv.git

        
    popd        
}
