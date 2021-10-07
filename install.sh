#!/bin/bash
# Install pynvim; vim-plug requires pynvim
if [[ "$(command -v pip2)" != "" ]]; then
  pip2 install --user pynvim jedi
fi
if [[ "$(command -v pip3)" != "" ]]; then
  pip3 install --user pynvim jedi
fi

# Install vim-plug
VIM_PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p nvim/autoload
curl -Lo nvim/autoload/plug.vim "$VIM_PLUG_URL"

# Download hanja.txt
HANJA_URL=https://github.com/choehwanjin/libhangul/raw/master/data/hanja/hanja.txt
curl -Lo hanja.txt "$HANJA_URL"

# Link neovim configuration to ~/.config/nvim
if [[ "$XDG_CONFIG_HOME" = "" ]]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi
nvimrc_name="init.nvim"
src_nvim_dir="$(pwd)/$(dirname "$0")/nvim"
src_nvimrc="$src_nvim_dir/$nvimrc_name"
dst_nvim_dir="$XDG_CONFIG_HOME/nvim"
dst_nvimrc="$dst_nvim_dir/$nvimrc_name"
if [[ ! -f "$dst_nvimrc" || "$(cat "$src_nvimrc")" != "$(cat "$dst_nvimrc")" ]]
then
  rm -f "$dst_nvim_dir"
  mkdir -p "$(dirname "$dst_nvim_dir")"
  ln -sfi "$src_nvim_dir" "$dst_nvim_dir"
fi

# Install plugins using vim-plug
nvim +PlugInstall +PlugUpdate +PlugClean! +qall
