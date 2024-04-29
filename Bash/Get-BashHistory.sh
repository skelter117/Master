#!/bin/bash

users=$(ls -d /home/*/ | grep -vE 'Default|Public' | sed 's|/home/||')

for user in $users; do
    history_file="/home/$user/.bash_history"
    
    echo "User: $user"
    
    if [ -f "$history_file" ]; then
        echo "Command History:"
        cat "$history_file"
    else
        echo "No command history found for $user."
    fi
    
    echo "---------------------"
done
