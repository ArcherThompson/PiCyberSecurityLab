#!/bin/bash

# Exit on any error
set -e

# Define paths
APACHE_DIR="/var/www/html"
PHP_TEMPLATE="./configs/template.php"
HTML_TEMPLATE="./configs/template.html"

# Remove existing content and set up the web page
echo "Setting up Apache web directory..."
sudo rm -rf ${APACHE_DIR}/*
if [ -f "$PHP_TEMPLATE" ] && [ -f "$HTML_TEMPLATE" ]; then
    sudo cp $PHP_TEMPLATE ${APACHE_DIR}/index.php
    sudo cp $HTML_TEMPLATE ${APACHE_DIR}/main.html
    echo ls $APACHE_DIR
else
    echo "Error: Required template files not found. Ensure $PHP_TEMPLATE and $HTML_TEMPLATE exist."
    exit 1
fi

# Ensure proper permissions
sudo chown -R www-data:www-data ${APACHE_DIR}
sudo chmod -R 755 ${APACHE_DIR}

echo "Apache configured successfully!"
