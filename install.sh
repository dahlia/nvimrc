#!/bin/bash
git submodule update --init
src_vimrc="$(pwd)/$(dirname "$0")/vimrc"
dst_vimrc="$HOME/.vimrc"
if [[ ! -f "$HOME/.vimrc" || "$(cat "$src_vimrc")" != "$(cat "$dst_vimrc")" ]]
then
  ln -sfi "$src_vimrc" "$dst_vimrc"
  ln -sfi "$(pwd)/$(dirname "$0")/vim" "$HOME/.vim"
fi
vim +PluginInstall +qall
vim +PluginClean! +qall
