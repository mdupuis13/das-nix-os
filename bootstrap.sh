#!/usr/bin/env bash

realuser=$(logname)

error() {
  printf '\E[31m'; echo "$@"; printf '\E[0m'
}


if [ `id -u` -ne 0 ]; then 
  error "Please run as root"
  exit -1
fi

lowercase(){
    echo "$1" | tr '[A-Z]' '[a-z]'
}

# All this to detec which OS is running !
OS=`lowercase \`uname\``
KERNEL=`uname -r`
MACH=`uname -m`

if [ "{$OS}" == "windowsnt" ]; then
    OS=windows
elif [ "{$OS}" == "darwin" ]; then
    OS=mac
else
    OS=`uname`
    if [ "${OS}" = "SunOS" ] ; then
        OS=Solaris
        ARCH=`uname -p`
        OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"
    elif [ "${OS}" = "AIX" ] ; then
        OSSTR="${OS} `oslevel` (`oslevel -r`)"
    elif [ "${OS}" = "Linux" ] ; then
        if [ -f /etc/redhat-release ] ; then
            DistroBasedOn='RedHat'
            DIST=`cat /etc/redhat-release |sed s/\ release.*//`
            PSEUDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
            REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
        elif [ -f /etc/SuSE-release ] ; then
            DistroBasedOn='SuSe'
            PSEUDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
            REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
        elif [ -f /etc/mandrake-release ] ; then
            DistroBasedOn='Mandrake'
            PSEUDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
            REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
        elif [ -f /etc/debian_version ] ; then
            DistroBasedOn='Debian'
            DIST=`cat /etc/os-release | grep '^NAME' | awk -F=  '{ print $2 }' | tr -d \"`
            PSEUDONAME=`cat /etc/os-release | grep '^ID=' | awk -F=  '{ print $2 }' | tr -d \"`
            REV=`cat /etc/debian_version`
        fi

        OS=`lowercase $OS`
        DistroBasedOn=`lowercase $DistroBasedOn`

        readonly OS
        readonly DIST
        readonly DistroBasedOn
        readonly PSEUDONAME
        readonly REV
        readonly KERNEL
        readonly MACH
    fi

fi
echo -e "OS:\t$OS"
echo -e "DIST:\t$DIST"
echo -e "DistroBasedOn:\t$DistroBasedOn"
echo -e "PSEUDONAME:\t$PSEUDONAME"
echo -e "REV:\t$REV"
echo -e "KERNEL:\t$KERNEL"
echo -e "MACH:\t$MACH"


case $DistroBasedOn in
  'debian')
    # get latest packages
    apt update

    # install alternative package manager
    apt install nala

    # get latest packages
    nala upgrade --assume-yes

    # install latest version available of git
    nala install git --assume-yes;;
  
  'RedHat')
    echo 'RedHat support not ready'
    exit -2;;

  'SuSe')
    echo 'SuSe support not ready'
    exit -2;;
esac



# create folder and move into $HOME/src/$USER
config_folder=/home/$realuser/src/
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
