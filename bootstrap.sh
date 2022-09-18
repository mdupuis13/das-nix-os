#!/usr/bin/env bash

realuser=$(id -u $(logname))

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}


if [ `id -u` -ne 0 ]; then 
  error "Please run as root"
  exit -1
fi

# get latest packages
#apt update

# install alternative package manager
#apt install nala

# get latest packages
#nala upgrade --assume-yes

# install latest version available of git
#nala install git --assume-yes


# create folder and move into $HOME/src/$USER
config_folder=$HOME/src/$USER
mkdir -p $config_folder

pushd $config_folder
    echo -e Cloning das-nix-os repo
    # clone das-nix-os repo
    git clone https://github.com/mdupuis13/das-nix-os.git das-nix-os

    chown $realuser:$realuser ./das-nix-os
popd

if [ -x das-nix-os/install-on-debian.sh ]; then
  echo launching das-nix-os/install-on-debian.sh...
fi
