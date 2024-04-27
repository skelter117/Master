#!/bin/bash

user=$(whoami)

sudo apt-get update -y

sudo git clone https://github.com/skelter117/master /home/$user/Downloads/master

sudo apt-get install snort -y

read -p "Enter the network(s) to monitor (CIDR notation or multiple networks separated by commas): " networks

snort_version=$(sudo snort --version | grep -oP 'Version \K\d+\.\d+')

echo "Detected Snort version: $snort_version"

if [[ $snort_version =~ 3\..* ]]; then 
    echo "Updating HOME_NET for Snort 3.x"
    sudo sed -i "s|^HOME_NET.*|HOME_NET = \"$networks\";|" /etc/snort/snort.lua
elif [[ $snort_version =~ 2\..* ]]; then 
    echo "Updating HOME_NET for Snort 2.x"
    sudo sed -i "s|^var HOME_NET.*|var HOME_NET $networks;|" /etc/snort/snort.conf
fi

sudo cp /home/$user/Downloads/master/Wordlists/Cheatsheets/SnortRulesCheatsheet.txt /etc/snort/rules/local.rules
