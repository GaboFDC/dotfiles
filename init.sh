#!/bin/bash -
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

#!/bin/bash

sudo yum update -y
sudo yum install -y vim git python36 gcc-c++ make cmake python3-devel
python3.6 -m ensurepip --user
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
sudo npm install -g pokemon-terminal diff-so-fancy

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

