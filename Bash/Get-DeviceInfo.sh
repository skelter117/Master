#!/bin/bash

read -p "Enter the IP address you want to check: " targetIP

# Validating IP address format
if ! [[ $targetIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP address format."
    exit 1
fi

# Retrieving system information
deviceModel=$(sudo dmidecode -t system | awk -F: '/Product Name/ {print $2}' | tr -d '[:space:]')
motherboardModel=$(sudo dmidecode -t baseboard | awk -F: '/Product Name/ {print $2}' | tr -d '[:space:]')
serialNumber=$(sudo dmidecode -t system | awk -F: '/Serial Number/ {print $2}' | tr -d '[:space:]')
ramCapacity=$(grep MemTotal /proc/meminfo | awk '{print $2 / 1024 / 1024}')
diskCapacity=$(df -h | awk '$6 == "/" {print $2}')
usedDiskSpace=$(df -h | awk '$6 == "/" {print $3}')
processorName=$(grep "model name" /proc/cpuinfo | uniq | awk -F: '{print $2}' | tr -d '[:space:]')
processorDescription=$(lscpu | grep "Model name" | awk -F: '{print $2}' | tr -d '[:space:]')
lastBootUpTime=$(uptime -s)
uptime=$(uptime -p)
macAddress=$(ip link | awk '$1 == "link/ether" {print $2; exit}')

# Printing system information
echo "Device Model is: $deviceModel"
echo "Motherboard Model is: $motherboardModel"
echo "Serial Number is: ${serialNumber:-Not Available}"
echo "Total RAM Capacity (GB): $ramCapacity"
echo "HDD/SSD Size (C: drive) (GB): $diskCapacity"
echo "Used Disk Space (C: drive) (GB): $usedDiskSpace"
echo "Processor Name is: $processorName"
echo "Processor Description: $processorDescription"
echo "Last Boot Up Time: $lastBootUpTime"
echo "Uptime: $uptime"
echo "MAC Address: ${macAddress:-Not Available}"


#if the device target is linux
#!/bin/bash

read -p "Enter the hostname or IP address you want to check on: " targetHostname

# Resolve the IP address of the target
targetIP=$(getent ahosts "$targetHostname" | awk '/^([0-9]{1,3}\.){3}[0-9]{1,3}/{print $1; exit}')

if [ -z "$targetIP" ]; then
    echo "Hostname not found or does not have an IP address."
else
    # Retrieve system information
    model=$(sudo dmidecode -s system-product-name)
    motherboard=$(sudo dmidecode -s baseboard-product-name)
    serial=$(sudo dmidecode -s system-serial-number)
    ram_capacity=$(free -h | awk '/^Mem:/{print $2}')
    disk_capacity=$(df -h | awk '/^\/dev\/[a-z]/ && $NF=="/"{print $2}')
    used_disk_space=$(df -h | awk '/^\/dev\/[a-z]/ && $NF=="/"{print $3}')
    processor=$(cat /proc/cpuinfo | grep "model name" | uniq | cut -d ":" -f 2 | sed 's/^[ \t]*//')
    last_bootup=$(uptime -s)
    current_user=$(who | awk 'NR==1{print $1}')

    echo "Target IP: $targetIP"
    echo "Device Model: $model"
    echo "Motherboard Model: $motherboard"
    echo "Serial Number: ${serial:-Not Available}"
    echo "Total RAM Capacity: $ram_capacity"
    echo "Disk Capacity: $disk_capacity"
    echo "Used Disk Space: $used_disk_space"
    echo "Processor Name: $processor"
    echo "Last Bootup Time: $last_bootup"
    echo "Currently logged-in user: $current_user"
fi
