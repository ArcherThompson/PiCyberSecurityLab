# **PiCyberSecurityLab**
A beginner-friendly cybersecurity lab setup designed for Raspberry Pi. This lab includes essential services like a web server, DNS server, FTP server, and a Python-based interactive story database to provide a practical environment for learning and testing cybersecurity skills.

!!!! Please note there are many security bugs in this system designed for exploitation do not use any of this for production environments !!!!

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

# **Setup Instructions**
1. Clone the Repository
```
git clone <repository_url>
cd PiCyberSecurityLab/setup.scripts
```
2. Run the Master Setup Script
The setup_all.sh script installs and configures all components:

```
chmod +x setup_all.sh
./setup_all.sh
```
3. Test the Setup
Verify that all services are running using the test_all.sh script:

```
chmod +x test_all.sh
./test_all.sh
```
# **Using the Interactive Story Environment**
Edit the Story:

An LLM prompt is provided to help with fast story-building.

Modify the world_building/story.markup file with your custom story.
Process the Story:

Run the config_python.sh script to process the new story:
```
chmod +x world_building/config_python.sh
./world_building/config_python.sh
```
View the Story Data:

Access the SQLite database:
bash
Copy code
sqlite3 /var/www/html/story_data/story.db
SELECT * FROM story;
SELECT * FROM locations;
SELECT * FROM objects;
# **Contributing**
Contributions are welcome! To suggest improvements or new features, please open an issue or submit a pull request.

# **License**
This project is licensed under the MIT License. See the LICENSE file for more information.





