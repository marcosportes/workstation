#!/bin/bash


echo "
Made by: github.com/marcosportes

      ╔═══════════════════════════════════════════════════════════════════╗              
      ║          ░█▀█░█▀█░█▀▀░▀█▀░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░           ║
      ║          ░█▀▀░█░█░▀▀█░░█░░░░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░           ║
      ║          ░▀░░░▀▀▀░▀▀▀░░▀░░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀           ║
      ║                                                                   ║
      ║                        FOR UBUNTU/BASED                           ║
      ╠═══════════════════════════════════════════════════════════════════╣
      ║ Recommended before any installation upgrade packages (Option 00)  ║
      ║                                                                   ║
      ║ 0 | Apt-get update                                                ║
      ║ 1 | Only Dpkg packs                                               ║
      ║ 2 | Only Flatpaks                                                 ║
      ║ 3 | Only Snaps                                                    ║
      ║ 4 | Only Python packs (Pip)                                       ║
      ║ 5 | Download external packs                                       ║
      ║ 6 | Setups                                                        ║  
      ║ 00| Upgrade and clear packages junk                               ║
      ║                                                                   ║
      ║    ▐ Type <all> to run ALL options                                ║
      ║                                                                   ║
      ║                                                   Ctrl+C for exit ║
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
  ========== INSTALLING APT PACKS ===========================================================
  "
  echo "Removing occasional apt locks:"
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock 
  
  echo "Adding repositories:"
  apt_repo=(
   ppa:numix/ppa
   ppa:ytvwld/asciiquarium  
  )
  for add_repo in "${apt_repo[@]}"; do
   sudo add-apt-repository -y "$add_repo"
   sudo apt update
  done
  echo "done"

  apt_packs=(
   zsh
   tilix
   git
   snapd
   curl
   wget
   flatpak
   vim
   htop
   btop ## htop better alternative 
   tldr ## mini manual for tools
   exa  ## ls alternative
   ncdu ## df -h alernative
   bat  ## cat alternative (batcat)
   python3-pip
   lua5.4
   gnome-tweaks
   numix-icon-theme-square
   flameshot
   asciiquarium
   neofetch
   lollypop
   qbittorrent
   libcurses-perl
  )
  for apt_names in "${apt_packs[@]}"; do
   if ! dpkg -s "$apt_names" &>/dev/null; then  ## install if not already installed
     sudo apt install "$apt_names" -y
     echo "[OK!] •  $apt_names "
   else
     echo "[Already installed!] ✔  $apt_names "
    fi
  done
}



function2() {
  echo " 
  ========== INSTALLING PACKS FROM FLATHUB ===================================================
  "
  echo "Adding repositories: "
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo "done!"
  
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
     sudo flatpak install flathub "$flatpak_names" -y
     echo "[OK!] • $flatpak_names "
   else
     echo "[Already installed!] ✔ $flatpak_names"
   fi
  done
}



function3() {
  echo " 
  ========== INSTALLING PACKS FROM SNAPCRAFT =================================================
  "
  snap_packs=(
    authy
  )
  for snap_names in "${snap_packs[@]}"; do
   if ! snap list | grep -q "$snap_names"; then
     sudo snap install "$snap_names"
     echo "[OK!] • $snap_names "
   else
     echo "[Already installed!] ✔ $snap_names"
   fi
  done
}



function4() {
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
       sudo pip install "$pip_name"
       echo "[OK!] • $pip_name"
     fi
  done
}



function5() {
  echo "
  ========== DOWNLOADING EXTERNAL PACKS ======================================================
  "
  wget_links=(
    vscode=   "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  )
  for wget_downloads in "${wget_links[@]}"; do
   wget -c "$wget_downloads" -P /home/"$USER"/Downloads;
   echo "
   File downloaded in ~/Downloads
  "
  done
}



function6() {
  echo " 
  ========== SETUPS ===========================================================================
  "
  echo "ZSH has default shell:"
  sudo chsh -s /bin/zsh

  echo "
  External auto install:
  "
# yarn -----------------
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
  yarn install --frozen-lockfile #dependence for coc in nvim 


# nvm ------------------
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  echo "Installing lts node:"
  source ~/.nvm/nvm.sh 
  nvm install --lts


#  Safe npm, a Security Wrapper for npm and npx ---------
  npm install -g @socketsecurity/cli


# zsh plugins: zsh-autosuggestions and zsh-syntax-highlighting
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$USER/.oh-my-zsh/$ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/$ZSH_CUSTOM/plugins/zsh-syntax-highlighting

#oh-my-zsh -------------
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

#tldr
  tldr update


}



function00() {
  echo " 
  ========== UPGRADE SYSTEM AND CLEANING: =====================================================
  "
  sudo dnf upgrade --refresh -y
  flatpak update -y
  sudo dnf autoremove -y

}



case "$option" in
  
  0) function0 ;;

  1) function1 ;;
  
  2) function2 ;;
  
  3) function3 ;;
  
  4) function4 ;;

  5) function5 ;;

  6) function6 ;;

  00) function00 ;;

  all) function0 && function1 && function2 && function3 && function4 && function5 && function6 && function00 ;;
  
  *) echo "Invalid option!" ;;
esac


echo "
                        ============================ Done! ==============================
 
 "
