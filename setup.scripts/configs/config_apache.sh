#!/bin/bash

# Exit on any error
set -e

# Remove existing content and set up a basic PHP web page
echo "Setting up Apache web directory..."
sudo rm -rf /var/www/html/*
cat <<EOF | sudo tee /var/www/html/index.php
<?php
echo "<h1>Welcome to the Story Adventure!</h1>";
echo "<p>Dynamic content will be loaded from the database.</p>";
?>
EOF

# Ensure proper permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "Apache configured successfully!"
