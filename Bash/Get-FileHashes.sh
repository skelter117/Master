#!/bin/bash

read -p "Enter the file name: " fileName

filePath=$(realpath "$fileName")

if [ -f "$filePath" ]; then
    sha256=$(sha256sum "$filePath" | awk '{print $1}')
    md5=$(md5sum "$filePath" | awk '{print $1}')
    sha1=$(sha1sum "$filePath" | awk '{print $1}')

    echo "SHA-256 hash: $sha256"
    echo "MD5 hash: $md5"
    echo "SHA1 hash: $sha1"
else
    echo "Error: File not found or invalid path."
fi