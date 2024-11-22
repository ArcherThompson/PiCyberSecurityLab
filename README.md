# **PiCyberSecurityLab**
A beginner-friendly cybersecurity lab setup designed for Raspberry Pi. This lab includes essential services like a web server, DNS server, FTP server, and a Python-based interactive story database to provide a practical environment for learning and testing cybersecurity skills.

---

## **Features**
- **Apache Web Server**:
  - Hosts a simple website with interactive content.
- **DNS Server**:
  - Configured with vulnerable settings for experimentation.
- **FTP Server**:
  - Includes anonymous login for testing common security vulnerabilities.
- **Interactive Story Environment**:
  - Powered by Python and SQLite to simulate a real-world application.

---

##Setup Instructions
1. Clone the Repository
bash
Copy code
git clone <repository_url>
cd PiCyberSecurityLab/setup.scripts
2. Run the Master Setup Script
The setup_all.sh script installs and configures all components:

bash
Copy code
chmod +x setup_all.sh
./setup_all.sh
3. Test the Setup
Verify that all services are running using the test_all.sh script:

bash
Copy code
chmod +x test_all.sh
./test_all.sh
Individual Component Setup
If you prefer to install and configure components individually, follow these steps:

1. Install and Configure Apache
Install the Apache web server and configure it:

bash
Copy code
chmod +x installs/install_apache.sh
./installs/install_apache.sh
chmod +x configs/config_apache.sh
./configs/config_apache.sh
2. Install and Configure DNS
Set up the DNS server with vulnerable configurations:

bash
Copy code
chmod +x installs/install_dns.sh
./installs/install_dns.sh
chmod +x configs/config_dns.sh
./configs/config_dns.sh
3. Install and Configure FTP
Install and configure the FTP server with anonymous login:

bash
Copy code
chmod +x installs/install_vsftpd.sh
./installs/install_vsftpd.sh
chmod +x configs/config_vsftpd.sh
./configs/config_vsftpd.sh
4. Set Up Python Environment
Install Python and configure the story environment:

bash
Copy code
chmod +x installs/install_python.sh
./installs/install_python.sh
chmod +x world_building/config_python.sh
./world_building/config_python.sh
Testing and Verification
Test All Components
Run the test_all.sh script to verify all components:

bash
Copy code
chmod +x test_all.sh
./test_all.sh
Verify Individual Components
Apache:
Open http://<Pi_IP> in a browser.
Look for the message: Welcome to the Story Adventure!
DNS:
Use dig to test DNS resolution:
bash
Copy code
dig @localhost example.com
FTP:
Test if the FTP server responds:
bash
Copy code
echo "QUIT" | nc -w 2 localhost 21
Story Environment:
Check if the SQLite database exists:
bash
Copy code
ls /var/www/html/story_data/story.db
Using the Interactive Story Environment
Edit the Story:

Modify the world_building/story.markup file with your custom story.
Process the Story:

Run the config_python.sh script to process the new story:
bash
Copy code
chmod +x world_building/config_python.sh
./world_building/config_python.sh
View the Story Data:

Access the SQLite database:
bash
Copy code
sqlite3 /var/www/html/story_data/story.db
SELECT * FROM story;
SELECT * FROM locations;
SELECT * FROM objects;
Contributing
Contributions are welcome! To suggest improvements or new features, please open an issue or submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for more information.

Copy code





