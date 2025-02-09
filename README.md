# cPanel Compromise Detection Plugin

This plugin scans all cPanel accounts on the server to detect potential signs of compromise. It checks Apache logs, `.htaccess` files, SSH logs, cron jobs, and other critical areas of the server for suspicious activity. When any potential compromise is detected, it logs the activity and sends an email notification to the administrator.

## Features

- **Apache Log Scan**: Detect suspicious POST requests and `eval()` usage.
- **Suspicious File Detection**: Look for compromised files in `public_html` directories.
- **SSH Log Analysis**: Look for failed SSH login attempts.
- **Cron Jobs and .htaccess Monitoring**: Detect unauthorized modifications.
- **Email Alerts**: Receive email notifications when compromised accounts are detected.
- **Logging**: View detailed logs for all detected activities.

## Installation

### Prerequisites

- A **cPanel server** running on a supported version.
- Root access to the server.
- **cPanel & WHM** installed and configured.
- **Postfix** or any other MTA configured for sending email notifications.

### Steps to Install

1. **Clone or Download the Repository:**

   Clone the repository or download it as a ZIP file:

   ```bash
   git clone https://github.com/iammaksudul/cpanel-compromise-detection-plugin.git
   ```

2. **Upload the Files to Your cPanel Plugin Directory:**

   Navigate to the `/usr/local/cpanel/whostmgr/docroot/cgi/` directory and upload the files from the cloned repository.

3. **Run the `install.sh` Script:**

   Make the script executable and run it:

   ```bash
   sudo bash /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/install.sh
   ```

   This script installs the necessary files and sets up the plugin on the cPanel server.

4. **Verify Installation:**

   - After installation, log into WHM.
   - You should now see the **Compromise Detection** plugin listed in the plugins section.

5. **Setup Email Notifications:**

   Ensure that your cPanel server is configured to send email notifications to the administrator when a potential compromise is detected. Verify the email setup via **WHM > Exim Configuration Manager**.

---

## Usage

### Starting the Scan

Once the plugin is installed and configured, you can run a scan through WHM:

1. Log into **WHM**.
2. Navigate to the **Compromise Detection** plugin.
3. Click **Start Scan** to begin the scan for all cPanel accounts.

The plugin will scan the Apache access logs, `.htaccess` files, SSH logs, cron jobs, and other critical server areas for suspicious activity. If a potential compromise is found, the system will log the details and send an email to the administrator.

### Log Details

The plugin maintains detailed logs for each detected activity. These logs can be accessed through the **Compromise Detection** plugin's UI in WHM. It provides an easy way to view the actions taken and identify accounts that need further attention.

### Email Alerts

You will receive an email notification if any suspicious activities are found. This includes detected issues like suspicious file modifications, unauthorized SSH login attempts, and changes in `.htaccess` files.

---

## Uninstallation

To uninstall the plugin:

1. Navigate to the plugin directory:
   
   ```bash
   cd /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
   ```

2. Run the uninstallation script:

   ```bash
   sudo bash uninstall.sh
   ```

This will remove all the installed files and stop the plugin from running.

---

## Contributing

If you'd like to contribute to the development of the **cPanel Compromise Detection Plugin**, feel free to fork the repository, make your changes, and submit a pull request. Your contributions are greatly appreciated!

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

For any questions or issues, feel free to reach out at **[dm@maksudulalam.com](mailto:dm@maksudulalam.com)**.

---

