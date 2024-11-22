#!/bin/bash

# Exit on any error
set -e

# Install Python and required packages
echo "Installing Python and dependencies..."
sudo apt update
sudo apt install -y python3 python3-pip python3-venv sqlite3 libsqlite3-dev

# Ensure the story data directory exists with correct permissions
STORY_DATA_DIR="/var/www/html/story_data"
if [ ! -d "$STORY_DATA_DIR" ]; then
    echo "Story data directory does not exist. Creating it..."
    sudo mkdir -p $STORY_DATA_DIR
    sudo chown -R $USER:www-data $STORY_DATA_DIR
    sudo chmod -R 775 $STORY_DATA_DIR
else
    echo "Story data directory already exists. Skipping creation."
fi

# Create a virtual environment for Python
VENV_DIR="$STORY_DATA_DIR/venv"
if [ ! -d "$VENV_DIR" ]; then
    echo "Setting up a Python virtual environment at $VENV_DIR..."
    python3 -m venv $VENV_DIR
    if [ ! -d "$VENV_DIR" ]; then
        echo "Error: Virtual environment creation failed. Exiting."
        exit 1
    fi
else
    echo "Virtual environment already exists at $VENV_DIR."
fi

# Activate the virtual environment and install required packages
echo "Activating virtual environment and installing Flask..."
source $VENV_DIR/bin/activate
pip install --upgrade pip
pip install flask
deactivate

echo "Python and Flask installed in virtual environment at $VENV_DIR."
