#!/bin/bash

# Exit on any error
set -e

# Install Apache
echo "Installing Apache..."
sudo apt update
sudo apt install -y apache2

# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

echo "Apache installed and running."
