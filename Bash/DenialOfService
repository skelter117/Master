#!/bin/bash

# Prompt the user to enter the IP address, hostname, or private IP to ping
read -p "Enter the IP address, hostname, or private IP to ping: " targetIP

# Set the fastest ping available to that IP variable
fastestPing=$(ping -c 5 "$targetIP" | grep 'min/avg/max' | awk -F '/' '{print $5}')

# Start an infinite ping in a single terminal window with 65500 bytes
ping "$targetIP" -s 65500
