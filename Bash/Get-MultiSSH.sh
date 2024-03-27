#!/bin/bash

IP1=""
IP2=""
IP3=""
IP4=""
Privatekeypath="path/to/private/key"
username="user"

if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Please install tmux."
    exit 1
fi

tmux new-session -d -s main -n "main" "ssh -i $Privatekeypath $username@$IP1"
tmux split-window -v -t main:0 "ssh -i $Privatekeypath $username@$IP2"
tmux split-window -h -t main:0 "ssh -i $Privatekeypath $username@$IP3"
tmux split-window -h -t main:0 "ssh -i $Privatekeypath $username@$IP4"
tmux attach-session -t main
