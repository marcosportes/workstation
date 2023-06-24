#! /bin/bash
## Post install for Fedora 38

echo "
Made by: github.com/marcosportes

      ╔═══════════════════════════════════════════════════════════════════╗              
      ║          ░█▀█░█▀█░█▀▀░▀█▀░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░           ║
      ║          ░█▀▀░█░█░▀▀█░░█░░░░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░           ║
      ║          ░▀░░░▀▀▀░▀▀▀░░▀░░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀           ║
      ║                                                                   ║
      ║                         FOR FEDORA 38                             ║
      ╠═══════════════════════════════════════════════════════════════════╣
      ║ Recommended before any installation upgrade packages (Option 00)  ║
      ║                                                                   ║
      ║ 0 | dnf update                                                    ║
      ║ 1 | Only dnf packs                                                ║
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
  ========== UPDATING DNF PACKS ========================================================
  "
  sudo dnf update
}



function1() {
  echo "
  ========== INSTALANDO PACOTES DNF ===========================================================
  "
  echo "Removendo bloqueios ocasionais do dnf:"
  sudo rm /var/lib/dnf/yumdb/lock
  sudo rm /var/lib/dnf/history.sqlite.{bz2,ini,lz4,xz,zstd}
  
  echo "Adicionando repositórios:"
  dnf_repo=(
   # repos here
  )
  for add_repo in "${dnf_repo[@]}"; do
   sudo dnf install -y "$add_repo"
  done
  echo "Concluído"

  dnf_packs=(
   zsh
   tilix
   git
   snapd
   cargo # rust package manager
   curl
   xclip # clipboard for nvim
   ripgrep # nvim - telescope dependence
   wget
   flatpak
   vim
   htop
   btop   # Alternativa melhor para o htop
   tldr   # Mini manual para ferramentas
   exa    # Alternativa ao ls
   ncdu   # Alternativa ao df -h
   bat    # Alternativa ao cat (batcat)
   python3-pip
   lua
   gnome-tweaks
   numix-icon-theme-square
   flameshot
   asciiquarium
   neofetch
  )
  for dnf_names in "${dnf_packs[@]}"; do
   if ! rpm -q "$dnf_names" &>/dev/null; then # Instala se ainda não estiver instalado
     sudo dnf install -y "$dnf_names"
     echo "[OK!] •  $dnf_names"
   else
     echo "[Already installed!] ✔  $dnf_names"
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
   com.spotify.Client
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
    # VSCode
    "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"  
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
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


#oh-my-zsh -------------
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

#tldr
  tldr update


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
