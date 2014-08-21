#!/bin/sh
git submodule update --init
ln -sfi `pwd`/`dirname $0`/vimrc $HOME/.vimrc
ln -sfi `pwd`/`dirname $0`/vim $HOME/.vim
vim +PluginInstall +qall
