#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "You need root privileges to run this script."
    exit 1
fi

while IFS=: read -r username _ uid gid info home shell; do
    password_hash=$(grep -E "^$username:" /etc/shadow | cut -d: -f2)
    echo "Username: $username"
    echo "Password hash (for CrackStation or John): ${password_hash:0:20}" 
    echo "--------------------------------------"
done < /etc/passwd