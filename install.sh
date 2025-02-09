#!/bin/bash

# Install Script for cPanel Compromise Detection Plugin

echo "Installing cPanel Compromise Detection Plugin..."

# Create the plugin directory in the correct location
mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

# Copy the correct script files from the current directory
cp /root/cpanel-compromise-detection-plugin/cpanel-compromise-detection.sh /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
cp /root/cpanel-compromise-detection-plugin/index.html /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
cp /root/cpanel-compromise-detection-plugin/plugin.conf /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
cp /root/cpanel-compromise-detection-plugin/whm_plugin.conf /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

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

# Ensure the plugin.conf and whm_plugin.conf files have correct permissions as well
chmod 644 /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/plugin.conf
chmod 644 /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/whm_plugin.conf

# Restart cPanel services to make the plugin active
/scripts/restartsrv_cpsrvd

echo "Installation completed. Access your plugin from WHM!"
