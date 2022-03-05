sudo apt install vim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# cp .vimrc_vundle ~/.vimrc
cp .vimrc ~/.vimrc


vim +PluginInstall +qall

# install ycm

git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive

# install Cmake
sudo apt install build-essential cmake vim-nox python3-dev
# Install mono-complete, go, node, java and npm
apt install mono-complete golang nodejs default-jdk npm

# Compile YCM
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all

# then configure python
cp global_extra_conf.py ~/
# then check:
# https://github.com/ycm-core/YouCompleteMe#python-semantic-completion
