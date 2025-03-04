#!/bin/bash

echo "
Made by: github.com/marcosportes
      ╔═══════════════════════════════════════════════════════════════════╗              
      ║          ░█▀█░█▀█░█▀▀░▀█▀░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░           ║
      ║          ░█▀▀░█░█░▀▀█░░█░░░░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░           ║
      ║          ░▀░░░▀▀▀░▀▀▀░░▀░░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀           ║
      ║                                                                   ║
      ║                        for Arch Based                             ║
      ╠═══════════════════════════════════════════════════════════════════╣
      ║ 0 | Pacman update                                                 ║
      ║ 1 | Only Arch Repo packs                                          ║
      ║ 2 | Only Flatpaks                                                 ║
      ║ 3 | Only AUR                                                      ║
      ║ 4 | Download external packs                                       ║
      ║ 5 | Setups                                                        ║  
      ║                                                                   ║
      ║ 00 | All Options                                                  ║
      ║                                                   Ctrl+C for exit ║
      ╚═══════════════════════════════════════════════════════════════════╝
                 
░ Enter an option:"
read -r option

function0() {
  sudo pacman -Syu
}

function1() {
  echo "
  ========== INSTALLING PACKS FROM ARCH REPOSITORIES ================================================
  "
  pacman_pack=./packages/pacman.txt
  mapfile -t pacman_packs <"$pacman_pack"

  for pacman_names in "${pacman_packs[@]}"; do
    if ! pacman -Qi "$pacman_names" &>/dev/null; then ## install if not already installed
      sudo pacman -S "$pacman_names" --noconfirm
      echo "[OK] •  $pacman_names "
    else
      echo "[Already installed!] ✔  $pacman_names "
    fi
  done
}

function2() {
  echo " 
  ========== INSTALLING PACKS FROM FLATHUB ===================================================
  "
  echo "Adding flathub repositorie: "
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo "done!"

  echo "Installing packs..."
  flatpak_packs=./packages/flatpak.txt
  mapfile -t flatpak_packs <"$flatpak_packs"

  for flatpak_names in "${flatpak_packs[@]}"; do
    if ! flatpak list | grep -q "$flatpak_names"; then
      flatpak install "$flatpak_names" -y
      echo "[OK] •  $flatpak_names "
    else
      echo "[Already installed!] ✔  $flatpak_names "
    fi
  done
}

function3() {
  echo " 
  ========== INSTALLING PACKS FROM AUR w/ PARU ===================================================
  "
  if ! command -v paru &> /dev/null; then
    echo "paru não encontrado. Instalando..."
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
  fi

  aur_packs=./packages/aur.txt
  mapfile -t aur_packs <"$aur_packs"
  for aur_name in "${aur_packs[@]}"; do
    if ! paru -Qq | grep -qx "$aur_name"; then
      paru -S --noconfirm "$aur_name"
      echo "[OK!] • $aur_name"
    else
      echo "[Already installed!] ✔ $aur_name"
    fi
  done
}

function4() {

  echo "Downloading external packs..."
  wget_links=(
    ""
  )
  for wget_downloads in "${wget_links[@]}"; do
    wget -c "${wget_downloads#*=}" -P "/home/$USER/Downloads"
    echo "
   File downloaded in ~/Downloads
  "
  done

  echo "plugins oh-my-zsh..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

}

function5() {

  echo "nvm install lts version..."
  nvm install --lts

}

case "$option" in

0) function0 ;;

1) function1 ;;

2) function2 ;;

3) function3 ;;

4) function4 ;;

5) function5 ;;

00) function0 && function1 && function2 && function3 && function4 && function5 ;;

*) echo "Invalid option!" ;;
esac
