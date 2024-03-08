#!/bin/bash

read -p "Enter the file or folder name, or file extension to search all locations: " searchQuery

if [ -z "$searchQuery" ]; then
    echo "Error: Search query is empty. Please provide a valid input."
    exit 1
fi

echo "Search query: $searchQuery"

results=$(find / -name "$searchQuery" -print 2>/dev/null)

if [ -n "$results" ]; then
    echo "Found items matching '$searchQuery':"
    echo "$results"
else
    echo "No items matching '$searchQuery' found."
fi