#!/bin/bash

sudo netstat -nltp

read -p "Enter the port number to investigate: " port

sudo lsof -i:$port

echo "After this, you may need to press CTRL+C to proceed with the script"

sudo systemctl --type=service

read -p "Enter the service name to investigate: " service

sudo systemctl status $service

read -p "Do you want to kill the process associated with service $service? (y/n): " kill_process
if [[ "$kill_process" =~ ^[Yy]$ ]]; then
    pid=$(sudo systemctl show -p MainPID -v $service | awk -F= '{print $2}')
    if [ -n "$pid" ]; then
        sudo kill -9 "$pid"
        echo "Process with PID $pid killed."
    else
        echo "No process found associated with service $service."
    fi
else
    echo "Process associated with service $service not killed."
fi

read -p "Do you want to stop service $service? (y/n): " stop_service
if [[ "$stop_service" =~ ^[Yy]$ ]]; then
    sudo systemctl stop "$service"
    echo "Service $service stopped."
else
    echo "Service $service not stopped."
fi

read -p "Do you want to disable service $service? (y/n): " disable_service
if [[ "$disable_service" =~ ^[Yy]$ ]]; then
    sudo systemctl disable "$service"
    echo "Service $service disabled."
else
    echo "Service $service not disabled."
fi
