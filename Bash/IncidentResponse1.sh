#!/bin/bash

# Function to block IP and port using iptables
block_ip_port() {
    ip_address=$1
    port=$2

    sudo iptables -A INPUT -p tcp --dport $port -s $ip_address -j DROP
    echo "IP $ip_address on port $port blocked."
}

while true; do
    echo "Listing TCP connections:"
    netstat -tuln

    read -p "Enter IP address or port number: " ip_or_port

    matching_connections=$(netstat -tuln | grep -E "($ip_or_port).*ESTABLISHED")

    if [ -n "$matching_connections" ]; then
        echo "$matching_connections" | while read -r connection; do
            process_id=$(echo "$connection" | awk '{print $7}' | cut -d'/' -f1)
            service=$(ps -p $process_id -o comm=)

            echo "Process ID: $process_id, Service: $service"

            malicious_service=$service
            malicious_process_id=$process_id
        done
    else
        echo "No matching connections found."
    fi

    read -p "Do you want to check another port number or IP address? (yes/no): " continue_check

    if [ "$continue_check" != "yes" ]; then
        break
    fi
done

if [ -n "$malicious_service" ] && [ -n "$malicious_process_id" ]; then
    read -p "Do you believe the process ($malicious_process_id) running $malicious_service is malicious and want to stop it? (yes/no): " malicious_decision

    if [ "$malicious_decision" = "yes" ]; then
        read -p "Do you want to kill the process? (yes/no): " kill_process
        if [ "$kill_process" = "yes" ]; then
            sudo kill $malicious_process_id
            echo "Process $malicious_process_id stopped."
        fi
    fi

    read -p "Do you want to deny the IP and port? (yes/no): " deny_ip_port
    if [ "$deny_ip_port" = "yes" ]; then
        block_ip_port "$ip_or_port"
    fi
fi
