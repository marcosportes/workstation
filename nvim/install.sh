#! /bin/bash

echo "
Installing AppImage Neovim (Latest version):
"
echo "Download/Install:"
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
   chmod u+x nvim.appimage
   ./nvim.appimage --appimage-extract
   ./squashfs-root/AppRun --version
   sudo mv squashfs-root /
   sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
echo "Done"


echo "Installing vim-plug"
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Done!"


# After downloading and giving an error in the coc, run in ~/.config/nvim/plugged: $ yarn install 




