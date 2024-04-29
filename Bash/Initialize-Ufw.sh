#!/bin/bash

echo "Updating..."
sudo apt-get update -y && echo "Updated." || { echo "Update failed."; exit 1; }

echo "Installing UFW firewall..."
sudo apt-get install ufw -y && echo "UFW firewall installed." || { echo "Installation failed."; exit 1; }

echo "Checking open ports..."
OpenPorts=$(ss -tuln | awk 'NR>1 {print $5}' | cut -d':' -f2 | sort -u)
echo "Open ports: $OpenPorts"

echo "Creating allow rules..."
for port in $OpenPorts; do 
  echo "Allowing port: $port..."
  sudo ufw allow $port
done

echo "Adding explicit deny rule..."
sudo ufw default deny incoming

read -p "Do you want to allow ssh from a specific IP? (yes/no): " response
if [[ $response == "yes" ]]; then
  read -p "Which IP do you want to allow? " IP
  sudo ufw allow from $IP to any proto tcp port 22
else
  echo "Okay, not allowing SSH from a specific IP."
fi

read -p "Do you want to enable the firewall? (y/n): " decision
if [[ "$decision" =~ ^[Yy]$ ]]; then
  sudo ufw enable && echo "Firewall enabled." || { echo "Failed to enable firewall."; exit 1; }
else
  echo "Firewall not enabled."
fi

exit 0

