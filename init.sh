#!/bin/bash
#===============================================================================
#
#          FILE: init.sh
#
#         USAGE: ./init.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 08/01/2019 08:05:48 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "Updating..."
sudo yum update -y

echo -e "\n\n\nInstalling git, py, devel..."
sudo yum install -y git python3 gcc-c++ make cmake python3-devel cowsay fortune-mod epel-release

echo -e "\n\n\nInstalling git-completion..."
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

echo -e "\n\n\nInstalling good ipcalc..."
if [ -d /opt/ipcalc-0.41 ] || type ipcalc; then
    echo "ipcal already installed"
else
    cd /opt/ || exit
    sudo wget http://jodies.de/ipcalc-archive/ipcalc-0.41.tar.gz
    sudo tar -xzvf ipcalc-0.41.tar.gz
    cd - || exit
fi

echo -e "\n\n\nInstalling pip..."
python3 -m ensurepip --user

#pip3 install flake8 pylint ansible-lint bashate --user

echo -e "\n\n\nInstalling npm..."
if type npm; then
    echo "NPM already exists"
else
    curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
    sudo yum install nodejs -y
fi

echo -e "\n\n\nInstalling fancy diff..."
sudo npm install -g diff-so-fancy

CURDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P)"
echo -e "\n\n\n"
read -n 1 -r -p "Create vim symlinks [ $CURDIR -> ~ ]? (y/N): "
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ln -s "$CURDIR"/.vimrc ~
fi

echo -e "\n\n\n"
read -n 1 -r -p "Install pkmn terminal? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo npm install -g pokemon-terminal
fi

echo -e "\n\n\nInstalling vim plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
