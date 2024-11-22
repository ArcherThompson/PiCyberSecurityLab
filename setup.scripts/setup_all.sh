#!/bin/bash

# Exit on any error
set -e

echo "Starting full setup of all components..."

# Step 1: Install Components
echo "Installing components..."
bash ./installs/install_apache.sh
bash ./installs/install_dns.sh
bash ./installs/install_vsftpd.sh

# Step 2: Configure Components
echo "Configuring components..."
bash ./configs/config_apache.sh
bash ./configs/config_dns.sh
bash ./configs/config_vsftpd.sh

# Step 3: Set up world-building environment
echo "Intsalling python venv..."
bash ./installs/install_python.sh
echo """
***
****
*****
test
"""
ls -a /var/www/html/story_data/
echo """
*****
****
***
"""
echo "Setting up world-building environment..."
bash ./world_building/config_python.sh

echo "Setup complete! All components have been installed and configured."
