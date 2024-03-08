#!/bin/bash

# Define function to retrieve unsuccessful logon attempts
get_unsuccessful_logons() {
    sudo journalctl -t Security -e | grep "ID=4625" | tail -n 30 | awk '{print $1, $8, $14}'
}

# Define function to retrieve successful logon attempts
get_successful_logons() {
    sudo journalctl -t Security -e | grep "ID=4624" | tail -n 30 | awk '{print $1, $8, $13}'
}

# Display unsuccessful logon attempts
echo "Last 30 Unsuccessful Logon Attempts:"
unsuccessful_logons=$(get_unsuccessful_logons)
if [ -n "$unsuccessful_logons" ]; then
    echo "$unsuccessful_logons" | column -t
else
    echo "No unsuccessful logon attempts found."
fi

# Display successful logon attempts
echo -e "\nLast 30 Successful Logon Attempts:"
successful_logons=$(get_successful_logons)
if [ -n "$successful_logons" ]; then
    echo "$successful_logons" | column -t
else
    echo "No successful logon attempts found."
fi