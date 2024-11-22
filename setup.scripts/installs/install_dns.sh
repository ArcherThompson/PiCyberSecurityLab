#!/bin/bash

# Exit on any error
set -e

# Install the bind9 package
echo "Installing DNS server (bind9)..."
sudo apt update
sudo apt install -y bind9

# Reload systemd to ensure all unit files are correctly loaded
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable and start the bind9 service explicitly
echo "Enabling and starting the bind9 service..."
sudo systemctl enable --now named

# Check the status of the service
if systemctl is-active --quiet named; then
    echo "DNS server installed and running."
else
    echo "Error: DNS server installation or startup failed."
    exit 1
fi
