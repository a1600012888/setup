#!/bin/bash




cp .tmux.conf ~
cp .bashrc ~
cp .profile ~

cd ~/
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh


