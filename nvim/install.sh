#! /bin/bash

echo "
Installing Neovim (Latest version):
"
echo "Download/Install:"
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
rm nvim-linux64.deb

mkdir ~/.config/nvim
mkdir ~/.config/lua

echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Done!"

# restore backed up files by creating a hard link

# After downloading and giving an error in the coc, run in ~/.config/nvim/plugged: $ yarn install 
