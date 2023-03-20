#!/bin/bash


USER="marpo"

echo "
Made by: github.com/marcosportes

                 ╔═══════════════════════════════════════════════════════════════════╗
                 ║                POST INSTALLATION FOR UBUNTU/BASED                 ║
                 ╠═══════════════════════════════════════════════════════════════════╣
                 ║  ATTENTION! Before any installation update packages (Option 0)!   ║
                 ║                                                                   ║
                 ║ 0 | Update Dpkg Packs                                             ║
                 ║ 1 | Add Repositories                                              ║
                 ║ 2 | Only Dpkg packs                                               ║
                 ║ 3 | Only Flatpaks                                                 ║
                 ║ 4 | Only Snaps                                                    ║
                 ║ 5 | Only Python packs (Pip)                                       ║
                 ║ 6 | Download external packs                                       ║
                 ║ 7 | Setups                                                        ║  
                 ║ 00| Upgrade and Cleaning Dpkg Packs                               ║
                 ║                                                                   ║
                 ║    ▐ Type <all> to run ALL options                                ║
                 ║                                                 Ctrl+C for exit   ║
                 ╚═══════════════════════════════════════════════════════════════════╝
                 
░ Enter an option:"
  read -r option



function0() {
  echo "
  ========== UPDATING Dpkg(apt) PACKS ========================================================
  "
  sudo apt-get update
}



function1() {
  echo " 
  ========== ADDING APT REPOSITORIES ========================================================
  "
  apt_repo=(
   ppa:numix/ppa
   ppa:ytvwld/asciiquarium  
  )
  for add_repo in "${apt_repo[@]}"; do
   sudo add-apt-repository --yes --update "$add_repo"
  done
}



function2() {
  echo " 
  ========== INSTALLING APT PACKS ===========================================================
  "

  echo "Removing occasional apt locks:"
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock

  apt_packs=(
   zsh
   tilix
   snapd
   flatpak
   vim
   htop
   python3-pip
   lua5.4
   gnome-tweaks
   numix-icon-theme-square
   flameshot
   asciiquarium
   calibre
   neofetch
   lollypop
   qbittorrent
   libcurses-perl
  )
  for apt_names in "${apt_packs[@]}"; do
   if ! dpkg -l | grep -q "$apt_names"; then  ## install if not already installed
     sudo apt install "$apt_names" -y
     echo "[OK!] •  $apt_names "
   else
     echo "[Already installed!] ✔  $apt_names "
    fi
  done
}



function3() {
  echo " 
  ========== INSTALLING PACKS FROM FLATHUB ===================================================
  "
  flathub_packs=(
   md.obsidian.Obsidian
   com.discordapp.Discord
   org.telegram.desktop
   com.obsproject.Studio
   org.audacityteam.Audacity
   com.spotify.Client
   com.brave.Browser
   org.videolan.VLC
  )
  for flatpak_names in "${flathub_packs[@]}"; do
   if ! flatpak list | grep -q "$flatpak_names"; then
     sudo flatpak install flathub "$flatpak_names" 
     echo "[OK!] • $flatpak_names "
   else
     echo "[Already installed!] ✔ $flatpak_names"
   fi
  done
}



function4() {
  echo " 
  ========== INSTALLING PACKS FROM SNAPCRAFT =================================================
  "
  snap_packs=(
    authy
  )
  for snap_names in "${snap_packs[@]}"; do
   if ! snap list | grep -q "$snap_names"; then
     sudo snap install "$snap_names" -y
     echo "[OK!] • $snap_names "
   else
     echo "[Already installed!] ✔ $snap_names"
   fi
  done
}



function5() {
  echo "
  ========== INSTALLING PYTHON PACKAGES ======================================================
  "
  pip_packs=(
   "pip"
   "pynvim" 
   "virtualenv"
   "pyright"
  )
  for pip_name in "${pip_packs[@]}"
  do
     if pip show "$pip_name" > /dev/null 2>&1; then
       echo "[Already installed!] ✔ $pip_name"
     else
       echo "Installing $pip_name ..."
       sudo pip install "$pip_name" -y
       echo "[OK!] • $pip_name"
     fi
  done
}



function6() {
  echo "
  ========== DOWNLOADING EXTERNAL PACKS ======================================================
  "
  wget_links=(
    vscode=   "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"  
    dropbox=  "https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb"
  )
  for wget_downloads in "${wget_links[@]}"; do
   wget -c "$wget_downloads" -P /home/"$USER"/Downloads;
   echo "
   File downloaded in ~/Downloads
  "
  done
}



function7() {
  echo " 
  ========== SETUPS ===========================================================================
  "
  echo "ZSH has default shell:"
  sudo chsh -s /bin/zsh

  echo "
  External auto install:
  "
#oh-my-zsh -------------
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# zsh plugins: zsh-autosuggestions and zsh-syntax-highlighting
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/marpo/.oh-my-zsh/$ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/marpo/.oh-my-zsh/$ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# nvm -------------------
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  echo "Installing lts node:"
  source ~/.nvm/nvm.sh 
  nvm install --lts

# yarn ------------------
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
  yarn install --frozen-lockfile #dependence for coc in nvim  

}



function00() {
  echo " 
  ========== UPGRADE SYSTEM AND CLEANING: =====================================================
  "
  sudo apt update && sudo apt dist-upgrade -y
  flatpak update -y
  sudo apt autoclean # clear packages junk
  sudo apt autoremove -y 
}



case "$option" in
  
  0) function0 ;;

  1) function1 ;;
  
  2) function2 ;;
  
  3) function3 ;;
  
  4) function4 ;;

  5) function5 ;;

  6) function6 ;;

  7) function7 ;;

  00) function00 ;;

  all) function0 && function1 && function2 && function3 && function4 && function5 && function6 &&
  function7 && function00 ;;
  
  *) echo "Invalid option!" ;;
esac


echo "
                        ============================ Done! ==============================
 
 "
