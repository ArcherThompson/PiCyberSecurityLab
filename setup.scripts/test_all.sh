#!/bin/bash

# Exit on any error
set -e

echo "Starting tests for all components..."

# Ensure dig is available
if ! command -v dig &> /dev/null; then
    echo "dig command not found. Installing dnsutils..."
    sudo apt update
    sudo apt install -y dnsutils
fi

# Step 1: Test Apache
echo "Testing Apache server..."
APACHE_URL="http://localhost"
APACHE_RESPONSE=$(curl -s "$APACHE_URL")
if [[ -n "$APACHE_RESPONSE" ]]; then
    echo "Apache is running and serving content."
else
    echo "Error: Apache is not serving any content."
    exit 1
fi

# Step 2: Test Python and Story Processing
echo "Testing Python story processing..."
if [[ -f /var/www/html/story_data/story.db ]]; then
    echo "Python script successfully created the SQLite database."
else
    echo "Error: Python script did not create the SQLite database."
    exit 1
fi

# Step 3: Test DNS
echo "Testing DNS server..."
if dig @localhost example.com | grep -q "ANSWER SECTION"; then
    echo "DNS server is running and resolving queries."
else
    echo "Error: DNS server is not resolving queries."
    exit 1
fi

# Step 4: Test FTP Server
echo "Testing FTP server..."
if echo "QUIT" | nc -w 2 localhost 21 | grep -q "220"; then
    echo "FTP server is running and accepting connections."
else
    echo "Error: FTP server is not responding on port 21."
    exit 1
fi

echo "All tests passed successfully!"
