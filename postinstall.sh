#! /bin/bash


USER="marpo"
echo " ===================== POST INSTALLATION START ====================== "

sudo apt update

echo " 
----------- ADDING APT REPOSITORIES: ------------------------------------------------------------
"
apt_repo=(
  ppa:numix/ppa
  ppa:ytvwld/asciiquarium  
)
for add_repo in ${apt_repo[@]}; do
  sudo add-apt-repository --yes --update "$add_repo"
done


echo " 
----------- INSTALLING APT PACKS: ---------------------------------------------------------------
"

echo "Removing occasional apt locks:"
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

apt_packs=(
  zsh
  tilix
  snapd
  vim
  htop
  python3-pip
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
for apt_names in ${apt_packs[@]}; do
  if ! dpkg -l | grep -q $apt_names; then  ## install if not already installed
    sudo apt install "$apt_names" -y
  else
    echo "[Already installed!] - $apt_names"
  fi
done

sudo apt update



echo " 
------------ INSTALLING PACKS FROM FLATHUB: -------------------------------------------------
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
for flatpak_names in ${flathub_packs[@]}; do
  if ! flatpak list | grep -q $flatpak_names; then
    sudo flatpak install flathub "$flatpak_names" -y
  else
    echo "[Already installed!] - $flatpak_names"
  fi
done



echo " 
------------ INSTALLING PACKS FROM SNAPCRAFT: -----------------------------------------------
"
snap_packs=(
  authy
)
for snap_names in ${snap_packs[@]}; do
  if ! snap list | grep -q $snap_names; then
    sudo snap install "$snap_names" -y
  else
    echo "[Already installed!] - $snap_names"
  fi
done



echo "
------------ INSTALLING PYTHON PACKAGES -----------------------------------------------------
"
pip_packs=(
  "pip" 
  "virtualenv"
)
for pip_name in "${pip_packs[@]}"
do
    if pip show $pip_name > /dev/null 2>&1; then
      echo "[Already installed!] - $pip_name"
    else
      echo "Installing $pip_name ..."
      sudo pip install $pip_name -y
      echo "$pip_name has been installed!"
    fi
done



echo " 
------------- DOWNLOADING EXTERNAL PACKS: --------------------------------------------------- 
"
wget_links=(
  vscode             = "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  dropbox            = "https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb"
)
for wget_downloads in ${wget_links[@]}; do
  cd /home/$USER/Downloads; wget -c "$wget_downloads" 
done

echo "External auto install:"
# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# zsh plugins: zsh-autosuggestions and zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting



echo " 
------------- SETUPS: ---------------------------------------------------------------------
"
echo "ZSH has default shell:"
sudo chsh -s /bin/zsh

echo "Installing lts nvm:"
source ~/.bashrc # refresh cli
nvm install --lts 



echo " 
------------- UPGRADE SYSTEM AND CLEANING: ------------------------------------------------
"
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean # clear packages junk
sudo apt autoremove -y 



echo " ===================== POST INSTALLATION END ====================== "
