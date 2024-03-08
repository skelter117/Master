#!/bin/bash

# Function to check if a file exists and is readable
check_file() {
    if [ ! -f "$1" ]; then
        echo "Error: $1 does not exist or is not a regular file." >&2
        exit 1
    elif [ ! -r "$1" ]; then
        echo "Error: $1 is not readable." >&2
        exit 1
    fi
}

# Function to validate IP address or hostname
validate_input() {
    # Regular expression for IPv4, IPv6, and hostname
    ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^[a-zA-Z0-9][a-zA-Z0-9.-]{1,61}[a-zA-Z0-9]$'
    if ! [[ $1 =~ $ip_regex ]]; then
        echo "Error: Invalid IP address or hostname." >&2
        exit 1
    fi
}

# Check if log files exist and are readable
check_file "/var/log/auth.log"
check_file "/var/log/syslog"
check_file "/var/log/application.log"
check_file "/var/log/setup.log"

# Read target IP or hostname from user
read -p "Enter the IP or Hostname: " target
validate_input "$target"

echo "Security:"
sudo grep -E "level=2|level=3" /var/log/auth.log | tail -n 10

echo "System:"
sudo grep -E "level=2|level=3" /var/log/syslog | tail -n 10

echo "Application:"
sudo grep -E "level=2|level=3" /var/log/application.log | tail -n 10

echo "Setup:"
sudo grep -E "level=2|level=3" /var/log/setup.log | tail -n 10