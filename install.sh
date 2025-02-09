#!/bin/bash

# Install Script for cPanel Compromise Detection Plugin

echo "Installing cPanel Compromise Detection Plugin..."

# Create the plugin directory in the correct location
mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

# Ensure that you have the correct paths to your script files
# Replace "/path/to/your/cpanel-compromise-detection.sh" with the actual path of your script
cp /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.sh /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
cp /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/index.html /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

# Create a cPanel configuration file for the plugin
cat > /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.conf << EOF
PLUGIN_NAME="cPanel Compromise Detection"
PLUGIN_AUTHOR="Kh Maksudul Alam"
PLUGIN_DESCRIPTION="Detects potential signs of compromise for cPanel users."
PLUGIN_VERSION="1.0"
PLUGIN_LICENSE="MIT License"
PLUGIN_WEBSITE="https://www.maksudulalam.com/"

# Optional Configurations
PLUGIN_ENABLE_EMAIL_ALERTS="true"
PLUGIN_ALERT_EMAIL="admin@example.com"
EOF

# Set the appropriate permissions
chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

echo "Installation completed. Access your plugin from WHM!"
