#!/bin/bash

# Exit on any error
set -e

echo "Installing vsftpd..."
sudo apt update && sudo apt install -y vsftpd iptables-persistent

echo "Configuring vsftpd..."

# Backup the original configuration file
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

# Update or add required settings in the vsftpd configuration
sudo sed -i 's/^#listen=NO/listen=YES/' /etc/vsftpd.conf
sudo sed -i 's/^#listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd.conf
sudo sed -i 's/^anonymous_enable=.*/anonymous_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/^#local_enable=.*/local_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/^#write_enable=.*/write_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/^#chroot_local_user=.*/chroot_local_user=YES/' /etc/vsftpd.conf

# Ensure "allow_writeable_chroot" is set
if ! grep -q "^allow_writeable_chroot=YES" /etc/vsftpd.conf; then
    echo "allow_writeable_chroot=YES" | sudo tee -a /etc/vsftpd.conf
fi

# Restart vsftpd to apply the configuration changes
sudo systemctl restart vsftpd

# Verify the service is running
echo "Checking vsftpd status..."
if sudo systemctl is-active --quiet vsftpd; then
    echo "FTP server installed and running successfully."
else
    echo "Error: FTP server failed to start. Check the configuration and logs."
    exit 1
fi
