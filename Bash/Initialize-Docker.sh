#!/bin/bash

sudo apt-get update -y

sudo apt-get install docker.io -y

read -p "Would you like to start a container? (yes/no): " choice

if [[ $choice == "yes" ]]; then
    read -p "Which image would you like to use? (ubuntu/kali/centos): " image

    if [[ $image == "kali" ]]; then
        image="kalilinux/kali-rolling"
    fi

    read -p "What would you like to name the container? " name

    sudo docker run -d -t --name $name $image

    if sudo docker ps -a --format '{{.Names}}' | grep -q $name; then
        echo "$name is running."
        read -p "Would you like to enter it? (yes/no): " enter_container

        if [[ $enter_container == "yes" ]]; then
            sudo docker exec -it $name bash
        fi
    else
        echo "Failed to start $name."
    fi
else
    echo "Script stopped. Start the container manually when you're ready."
fi
