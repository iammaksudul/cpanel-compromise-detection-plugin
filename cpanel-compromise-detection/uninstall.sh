#!/bin/bash

# Uninstall Script for cPanel Compromise Detection Plugin

echo "Uninstalling cPanel Compromise Detection Plugin..."

# Remove plugin files and directories
rm -rf /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/

echo "Plugin uninstalled successfully."
