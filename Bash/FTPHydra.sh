#!/bin/bash

read -p "Enter the full path to the username list file or specify a single username: " username_input

if [ -f "$username_input" ]; then
    username_list="-L $username_input"
    single_username=""
else
    single_username="-l $username_input"
    username_list=""
fi

read -p "Enter the full path to the password list file or specify a single password: " password_input

if [ -f "$password_input" ]; then
    password_list="-P $password_input"
    single_password=""
else
    single_password="-p $password_input"
    password_list=""
fi

read -p "Enter the target IP or hostname: " target_ip

hydra_command="hydra $username_list $single_username $password_list $single_password ftp://$target_ip"

output=$(eval "$hydra_command")

echo "Executing the following command:"
echo "$hydra_command"
echo "Hydra output:"
echo "$output"

successful_logins=$(echo "$output" | grep -E "login:|password" | awk '{print $NF}')

if [ -n "$successful_logins" ]; then
    echo "Successful login attempts found:"
    echo "$successful_logins"
else
    echo "No successful login attempts found."
fi