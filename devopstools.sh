#! /bin/bash
## Creating a devops environment - Distro Ubuntu 22.04 and based


USER="marpo"   # change-me

echo "
Made by: github.com/marcosportes

        ╔═══════════════════════════════════════════════════════════════════╗
        ║          ░█▀▄░█▀▀░█░█░█▀█░█▀█░█▀▀░░░▀█▀░█▀█░█▀█░█░░░█▀▀           ║
        ║          ░█░█░█▀▀░▀▄▀░█░█░█▀▀░▀▀█░░░░█░░█░█░█░█░█░░░▀▀█           ║
        ║          ░▀▀░░▀▀▀░░▀░░▀▀▀░▀░░░▀▀▀░░░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀           ║
        ╠═══════════════════════════════════════════════════════════════════╣
        ║  Recommended before any installation upgrade packages (Option 0)  ║
        ║                                                                   ║
        ║ 0 | APT  Update/Upgrade                                           ║
        ║ 1 | Docker                                                        ║
        ║ 2 | Docker Compose                                                ║
        ║ 3 | Git                                                           ║
        ║ 4 | Ansible                                                       ║
        ║ 5 | Terraform                                                     ║
        ║ 00| Clear packages junk                                           ║  
        ║                                                                   ║
        ║     ▐ Type <all> to run ALL options                               ║   
        ║                                                  Ctrl+C for exit  ║
        ╚═══════════════════════════════════════════════════════════════════╝
                 
░ Enter an option:"
read -r tool

function0(){
    sudo apt update && sudo apt upgrade -y
}

function1()
{
    echo "
                     ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING DOCKER ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
    echo "### Docker install - Install using the repository ###"
    # Documentation: https://docs.docker.com/engine/install/ubuntu/
    echo -e "\n1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:"
    sudo apt install lsb-release ca-certificates curl gnupg vim apt-transport-https -y
        
    echo -e "\n2. Add Docker’s official GPG key:"
    sudo mkdir -m 0755 -p /etc/apt/keyrings -y
    #curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        
    echo -e "\n3. Use the following command to set up the repository:"
    #echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       
    echo -e "\nInstalling Docker Engine, containerd"
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
    sudo usermod -aG docker $USER
    echo -e "\nDOCKER has been installed!\n"
}

function2()
{
    echo -e "
                   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING DOCKER-COMPOSE ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
    sudo apt install docker-compose -y
    echo -e "\nDOCKER COMPOSE has been installed!\n"
}

function3()
{
    echo -e "
                        ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING GIT ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
    sudo apt install git -y      
    echo -e "\n GIT has been installed!\n"
}

function4()
{
    echo -e "
                       ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING ANSIBLE ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible -y
    echo -e "\n ANSIBLE has been installed!\n"
}

function5()
{
    echo -e "
                      ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING TERRAFORM ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
    echo -e "1. Download the signing key to a new keyring\n"
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo -e "Process concluded!\n"
    #wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
    echo -e "\n2. Add the HashiCorp repo"
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    echo -e "\n3.Update and install\n "
    sudo apt update
    sudo apt install terraform -y
    echo -e "\nTERRAFORM has been installed!\n"
}


function6()
{
    echo "
                    ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ INSTALLING ALL TOOLS ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
    "
}

function00()
{
    echo "### Cleaning packages junk... ###"
    sudo apt autoremove 
    sudo apt clean
    echo -e "\nCleaning finish!\n"
}

case $tool in 
    0)  function0 ;;
    
    1)  function1 ;;

    2)  function2 ;;

    3)  function3 ;;    

    4)  function4 ;;

    5)  function5 ;;

    all)  function1 && function2 && function3 && function4 && function5 
        echo -e "\n Tools Installed! \n"
    ;;

    00)  function00 ;;

    *)  echo "Invalid Option" ;;
esac


echo "

                           ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡ Done! ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡

"
