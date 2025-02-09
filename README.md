

# cPanel Compromise Detection Plugin

This cPanel plugin scans all cPanel accounts for signs of compromise by inspecting critical system files such as Apache logs, `.htaccess` files, SSH logs, and more. The plugin flags suspicious activity such as unauthorized SSH login attempts, suspicious PHP code, and modification of important files. It also offers the ability to send email alerts when suspicious activity is detected.

## Features

- **Apache Log Scan**: Detects suspicious POST requests and use of `eval()` functions.
- **Suspicious File Detection**: Checks `public_html` directories for compromised files, such as PHP files with `eval()` function.
- **SSH Log Analysis**: Monitors failed SSH login attempts to detect brute-force attempts.
- **Cron Jobs and .htaccess Monitoring**: Detects unauthorized modifications to cron jobs and `.htaccess` files.
- **Email Alerts**: Sends email notifications if compromised accounts are detected.
- **Comprehensive Logging**: Logs all detected suspicious activity for auditing and tracking purposes.

## Installation

### 1. Clone or Download the Repository

Clone the repository to your server or download it manually.

```bash
git clone https://github.com/iammaksudul/cpanel-compromise-detection-plugin.git
cd cpanel-compromise-detection
```

### 2. Run the Installation Script

Make the script executable and run it to install the plugin on your server.

```bash
chmod +x install.sh
sudo ./install.sh
```

This will install all necessary files in the cPanel plugin directory and set up the configuration.

### 3. Configure Email Alerts (Optional)

If you want to receive email notifications when suspicious activity is detected, make sure you configure the email address in the configuration file:

1. Open `cpanel-compromise-detection.conf` in a text editor:

```bash
nano /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.conf
```

2. Set your email address:

```bash
PLUGIN_ENABLE_EMAIL_ALERTS="true"
PLUGIN_ALERT_EMAIL="your-email@example.com"
```

### 4. Running the Plugin

The plugin can be triggered manually through the cPanel interface or by running the following command:

```bash
/usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.sh
```

This will scan all cPanel accounts on your server and log any suspicious activity.

## Configuration

The plugin includes an optional configuration file located at:

```bash
/usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.conf
```

You can customize the following settings:

- **PLUGIN_ENABLE_EMAIL_ALERTS**: Set this to `true` if you want email notifications for detected compromises.
- **PLUGIN_ALERT_EMAIL**: The email address that should receive the alerts.

Example:

```bash
PLUGIN_ENABLE_EMAIL_ALERTS="true"
PLUGIN_ALERT_EMAIL="admin@example.com"
```

## How the Scan Works

The plugin checks several areas for potential compromise:

1. **Apache Access Logs**: It checks for suspicious POST requests and `eval()` function usage.
2. **Public HTML Directory**: It scans `public_html` for PHP files with suspicious code.
3. **.htaccess File**: It checks for suspicious redirects and `php_value` entries in `.htaccess`.
4. **SSH Logs**: It looks for failed login attempts in `/var/log/secure`.
5. **Cron Jobs**: It monitors for unauthorized cron job entries.

If any suspicious activity is detected, the plugin flags the account as potentially compromised.

## Logs

All detected activities are logged in:

```bash
/usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/compromise_detection.log
```

You can view the logs to track any suspicious activities detected by the plugin.

## Uninstalling the Plugin

To uninstall the plugin, run the following command:

```bash
sudo ./uninstall.sh
```

This will remove the plugin and all associated files from your server.

## License

This plugin is open-source and available under the **MIT License**. You are free to use, modify, and distribute it as needed.

## Author

This plugin was developed by **[Kh Maksudul Alam](https://www.maksudulalam.com/)**. For support or inquiries, you can reach out via the website.

---

### Final Notes

This README provides clear and detailed instructions on how to install, configure, and run your **cPanel Compromise Detection Plugin**. It also provides instructions on email alert configurations, logging, and scanning processes to ensure the security of cPanel servers.
