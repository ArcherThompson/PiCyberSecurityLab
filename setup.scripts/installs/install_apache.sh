#!/bin/bash

# Exit on any error
set -e

# Install Apache and PHP
echo "Installing Apache and PHP..."
sudo apt update
sudo apt install -y apache2 php libapache2-mod-php php-sqlite3

# Enable the PHP module and restart Apache
PHP_VERSION="8.2" # Adjust this if using a different PHP version
echo "Enabling PHP module for version $PHP_VERSION..."
sudo a2enmod php${PHP_VERSION}

# Enable and start Apache
echo "Enabling and starting Apache..."
sudo systemctl enable apache2
sudo systemctl restart apache2

echo "Apache and PHP installed and running."
