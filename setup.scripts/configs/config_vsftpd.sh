#!/bin/bash
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
sudo sed -i 's/#anonymous_enable=NO/anonymous_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/local_enable=YES/#local_enable=YES/' /etc/vsftpd.conf
sudo sed -i 's/write_enable=YES/#write_enable=YES/' /etc/vsftpd.conf
sudo mkdir -p /srv/ftp
sudo chown nobody:nogroup /srv/ftp
sudo systemctl restart vsftpd
echo "FTP server configured with anonymous login."
