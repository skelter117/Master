#!/bin/bash

sudo apt-get update -y
sudo apt-get install docker.io -y

read -p "Would you like to start a container? (yes/no): " choice

if [[ $choice == "yes" ]]; then
    read -p "Which image would you like to use? (ubuntu/kali/centos): " image

    case $image in
        ubuntu)
            image="ubuntu:latest"
            ;;
        kali)
            image="kalilinux/kali-rolling:latest"
            ;;
        centos)
            image="centos:latest"
            ;;
        *)
            echo "Invalid image choice. Exiting script."
            exit 1
            ;;
    esac

    read -p "What would you like to name the container? " name

    # Pull the latest image
    sudo docker pull $image

    # Start the container
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
