#!/bin/bash
# Install and start Apache2 on Ubuntu EC2.

set -e

sudo apt update -y
sudo apt install apache2 -y
sudo systemctl enable --now apache2

HOSTNAME=$(hostname)
PRIVATE_IP=$(hostname -I | awk '{print $1}')

echo "<h1>Server Details</h1><p>Hostname: ${HOSTNAME}</p><p>Private IP: ${PRIVATE_IP}</p>" | sudo tee /var/www/html/index.html

echo "Apache is installed and running."
