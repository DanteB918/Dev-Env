#! /bin/bash

# Install all necessary packages for this application.

# Update
sudo apt-get update

#Docker
echo "Would you like to install docker? ONLY FOR UBUNTU & DEBIAN. (y/n)"

read dev

if [[ $dev == "y" ]];then
    #Following Docker Documentation here: https://docs.docker.com/engine/install/ubuntu/
    echo "Ubuntu or Debian? (u/d)"
    read you

    sudo apt-get install ca-certificates curl gnupg lsb-release

    sudo mkdir -p /etc/apt/keyrings

        if [[ $you == "d"]];then
        #Download for Debian
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

                echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        else
        #Download for Ubuntu
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

                echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        fi
        sudo apt-get update

        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi
#Docker composer
sudo apt install docker.io docker-compose -y

#Ansible
sudo apt-get install ansible

#Yad
sudo apt-get install yad

