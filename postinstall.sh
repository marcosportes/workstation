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
      ║ 1 | Only Pacman packs                                             ║
      ║ 2 | Only Flatpaks                                                 ║
      ║ 3 | Only Snaps                                                    ║
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
  ========== INSTALLING PACKS FROM PACMAN ====================================================
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
  snap_packs=./packages/snap.txt
  mapfile -t snap_packs <"$snap_packs"
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

  echo "Downloading external packs..."
  wget_links=(
    "vscode=https://az764295.vo.msecnd.net/stable/2ccd690cbff1569e4a83d7c43d45101f817401dc/code-stable-x64-1690491880.tar.gz"
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
