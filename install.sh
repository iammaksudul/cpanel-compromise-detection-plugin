#!/bin/bash

# Install Script for cPanel Compromise Detection Plugin

echo "Installing cPanel Compromise Detection Plugin..."

# Create the plugin directory
mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

# Copy script files
cp /path/to/your/cpanel-compromise-detection.sh /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/
cp /path/to/your/index.html /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

# Create a cPanel configuration file for the plugin
cat > /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.conf << EOF
PLUGIN_NAME="cPanel Compromise Detection"
PLUGIN_AUTHOR="Kh Maksudul Alam"
PLUGIN_DESCRIPTION="Detects potential signs of compromise for cPanel users."
PLUGIN_VERSION="1.0"
EOF

# Provide the necessary permissions
chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

echo "Installation completed. Access your plugin from WHM!"
