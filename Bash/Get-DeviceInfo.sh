#!/bin/bash

# Prompt the user to enter the hostname to check
read -p "Enter the hostname you want to check on: " targetHostname

# Get the IP address associated with the hostname
targetIP=$(host "$targetHostname" | grep 'has address' | awk '{print $4}')

if [ -z "$targetIP" ]; then
    echo "Hostname not found or does not have an IP address."
else
    # Get system information remotely
    deviceModel=$(ssh "$targetIP" dmidecode -s system-product-name)
    motherboardModel=$(ssh "$targetIP" dmidecode -s baseboard-product-name)
    serialNumber=$(ssh "$targetIP" dmidecode -s system-serial-number || echo "Not Available")
    ramCapacity=$(ssh "$targetIP" free -m | awk 'NR==2{print $2/1024}')
    diskCapacity=$(ssh "$targetIP" df -h | awk '$NF=="/"{print $2}')
    processorName=$(ssh "$targetIP" cat /proc/cpuinfo | grep "model name" | uniq | cut -d ":" -f 2 | sed 's/^ *//')
    processorDescription=$(ssh "$targetIP" lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^ *//')
    macAddress=$(ssh "$targetIP" cat /sys/class/net/*/address | head -n 1)
    windowsVersion=$(ssh "$targetIP" uname -a)
    lastBootUpTime=$(ssh "$targetIP" who -b | awk '{print $3,$4}')
    uptime=$(ssh "$targetIP" uptime | awk '{print $3,$4}')

    # Display system information
    echo "Device Model is: $deviceModel"
    echo "Motherboard Model is: $motherboardModel"
    echo "Serial Number is: $serialNumber"
    echo "Total RAM Capacity (GB): $ramCapacity"
    echo "HDD/SSD Size (C: drive) (GB): $diskCapacity"
    echo "Processor Name is: $processorName"
    echo "Processor Description: $processorDescription"
    echo "MAC Address: $macAddress"
    echo "Windows Version is: $windowsVersion"
    echo "Last Boot Up Time: $lastBootUpTime"
    echo "Uptime: $uptime"
fi