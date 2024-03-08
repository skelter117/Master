#!/bin/bash

# Prompt the user to enter the network in CIDR notation
read -p "Enter the network in CIDR that you want to restart: " subnet

# Get IP addresses of all active network interfaces
ipAddresses=$(ip -o -4 addr show | awk '{print $4}' | cut -d '/' -f 1)

# Function to check if an IP address is within the specified subnet
inSubnet() {
    local ip="$1"
    local subnet="$2"
    if [[ "$(ipcalc -n "$subnet" | cut -d '=' -f 2)" == "$(ipcalc -n "$ip/${subnet#*/}" | cut -d '=' -f 2)" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Function to restart the computer if it is reachable and within the specified subnet
restartComputer() {
    local ip="$1"
    if ping -c 1 "$ip" &> /dev/null && [[ $(inSubnet "$ip" "$subnet") == "true" ]]; then
        ssh "$ip" sudo systemctl restart network-manager
    fi
}

# Iterate through each IP address
for ip in $ipAddresses; do
    restartComputer "$ip"
done