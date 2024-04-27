#!/bin/bash

read -p "Enter username: " name

sudo adduser $name

if [ ! -d "/home/$name" ]; then
    sudo mkdir -p "/home/$name"
    sudo chown $name:$name "/home/$name"
fi

read -p "Add user to sudo group? (yes/no): " add_sudo

if [ "$add_sudo" == "yes" ]; then
    sudo usermod -aG sudo $name
fi

read -p "Generate SSH key? (yes/no): " generate_ssh

if [ "$generate_ssh" == "yes" ]; then
    sudo -u $name ssh-keygen -t rsa -b 4096 -C "$name@$HOSTNAME" -f "/home/$name/.ssh/id_rsa" -q -N ""
    echo "SSH keys generated."
fi

read -p "Would you like to upload the public key to a server? (yes/no): " upload_key 

if [ "$upload_key" == "yes" ]; then
    read -p "Enter the IP address of the server: " server_ip
    read -p "Enter the username on the server: " server_user
    read -p "Enter the path to copy the public key on the server: " server_path
    sudo -u $name ssh-copy-id -i "/home/$name/.ssh/id_rsa.pub" $server_user@$server_ip
    echo "Public key uploaded to server."
else
    echo "Exiting script."
    exit 0
fi
