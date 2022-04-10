#!/usr/bin/env bash

# install git + z shell 
echo "Installing base programs (git, zsh)"
apt-get install git zsh zsh-autosuggestions zsh-syntax-highlighting

# create folder and move into $HOME/src/$USER
mkdir -p src/$USER
cd src/$USER

# clone das-nix-os repo
git clone https://github.com/mdupuis13/das-nix-os.git

# clone dotfilez-dasboss-pc repo
git clone https://github.com/mdupuis13/dotfilez-dasboss-pc.git



# ask to install X or not
echo -n "Install an X environment ? Y/n: "
read -r p installX

case $installX in
      [yY][eE][sS]|[yY])
            echo "Install X Window stuff"
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
echo -n "Install an X environment ? Y/n: "
read -r p installX

case $installX in
      [yY][eE][sS]|[yY])
            echo "Install dev-env stuff"
            # if YES clone repo and run universal-devenv/install.sh
            isntall_devenv
            ;;
      [nN][oO]|[nN])
            echo "Not installing dev-env stuff..."
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac

function isntall_devenv() {
    # clone universal-devenv repo
    cd src/$USER
    git clone https://github.com/mdupuis13/universal-devenv.git
        
}
