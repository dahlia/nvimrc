#!/bin/sh
git submodule update --init
ln -s `pwd`/`dirname $0`/vimrc $HOME/.vimrc
ln -s `pwd`/`dirname $0`/vim $HOME/.vim
vim +PluginInstall +qall
