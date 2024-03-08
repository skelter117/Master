#!/bin/bash

read -p "Enter the hash value: " hash_value

hash_file=$(mktemp)
echo "$hash_value" > "$hash_file"

read -p "Enter the full path to the wordlist file: " wordlist_path

john --format=Raw-MD5 --pot=john.pot --wordlist="$wordlist_path" "$hash_file"

if [ -f "john.pot" ]; then
    cracked_hash=$(john --show "john.pot" | grep "$hash_value")
    if [ -n "$cracked_hash" ]; then
        echo "Hash cracked! Plain text password:"
        echo "$cracked_hash"
    else
        echo "Hash not cracked."
    fi
else
    echo "Hash not cracked."
fi

rm "$hash_file" "john.pot"