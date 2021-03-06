#!/bin/bash


sudo apt-get update

LIBS='libgoogle-glog-dev libgflags-dev libopencv-dev libpython-dev libpython3-dev python-numpy libprotobuf-dev libboost-dev libboost-filesystem-dev libboost-random-dev libboost-system-dev libboost-timer-dev libboost-date-time-dev libboost-log-dev libboost-thread-dev clang cmake htop protobuf-compiler vim-python-jedilibhiredis-dev ctags'

sudo apt-get install -y $LIBS


sudo cp .tmux.conf ~
sudo cp .bashrc ~
sudo cp .profile ~

pip3 install -r ./requirements.txt --user


# pip3 install https://download.pytorch.org/whl/cu100/torch-1.1.0-cp37-cp37m-linux_x86_64.whl
# pip3 install https://download.pytorch.org/whl/cu100/torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl


cd ~/
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh


