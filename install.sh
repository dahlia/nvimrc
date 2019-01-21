#!/bin/bash
# Install neovim-python; vim-plug requires neovim-python
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
curl -Lo hanja.txt \
     https://github.com/choehwanjin/libhangul/raw/master/data/hanja/hanja.txt

# Link neovim configuration to ~/.config/nvim
xdg_config_dir="$HOME/.config"
nvimrc_name="init.nvim"
src_nvim_dir="$(pwd)/$(dirname "$0")/nvim"
src_nvimrc="$src_nvim_dir/$nvimrc_name"
dst_nvim_dir="$xdg_config_dir/nvim"
dst_nvimrc="$dst_nvim_dir/$nvimrc_name"
echo "Neovim configuration directory: $dst_nvim_dir"
if [[ ! -f "$dst_nvimrc" || "$(cat "$src_nvimrc")" != "$(cat "$dst_nvimrc")" ]]
then
  rm -f "$dst_nvim_dir"
  mkdir -p "$xdg_config_dir"
  ln -sfi "$src_nvim_dir" "$dst_nvim_dir"
fi

# Install plugins using vim-plug
nvim +PlugInstall +PlugUpdate +PlugClean! +qall
