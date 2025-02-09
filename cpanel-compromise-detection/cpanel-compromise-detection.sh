#!/bin/bash

# Load the configuration settings
source /usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/cpanel-compromise-detection.conf

# Function to send email alerts
send_email_alert() {
    local user=$1
    local activity=$2
    echo -e "Subject: ALERT: Compromise Detected for cPanel User $user\n\n$activity" | sendmail -v "$PLUGIN_ALERT_EMAIL"
}

# Log file for recording detected issues
LOG_FILE="/usr/local/cpanel/whostmgr/docroot/cgi/cpanel-compromise-detection/compromise_detection.log"

echo "Starting scan for all cPanel accounts..." >> $LOG_FILE

# Get the list of all cPanel users from the system
CPANEL_USERS=$(ls /var/cpanel/users/)

# Loop through each user account
for USER in $CPANEL_USERS; do
    echo "Checking account: $USER" >> $LOG_FILE
    compromised=false
    activity=""

    # Check Apache access logs for suspicious activity
    ACCESS_LOG="/usr/local/apache/domlogs/$USER"
    if [ -f "$ACCESS_LOG" ]; then
        echo "Checking Apache access logs..." >> $LOG_FILE
        suspicious_access=$(grep -i "POST" "$ACCESS_LOG" | tail -n 20)
        suspicious_eval=$(grep -i "eval(" "$ACCESS_LOG" | tail -n 20)
        
        if [ ! -z "$suspicious_access" ] || [ ! -z "$suspicious_eval" ]; then
            activity+="Suspicious access found in Apache logs for user $USER.\n"
            compromised=true
        fi
    else
        echo "No Apache access logs found for user $USER." >> $LOG_FILE
    fi

    # Check for suspicious files in the public_html directory
    PUBLIC_HTML_DIR="/home/$USER/public_html"
    if [ -d "$PUBLIC_HTML_DIR" ]; then
        echo "Checking public_html directory for suspicious files..." >> $LOG_FILE
        suspicious_php_files=$(find "$PUBLIC_HTML_DIR" -type f -name "*.php" -exec grep -l "eval(" {} \;)
        
        if [ ! -z "$suspicious_php_files" ]; then
            activity+="Suspicious PHP files found in $USER's public_html directory.\n"
            compromised=true
        fi
    else
        echo "No public_html directory found for user $USER." >> $LOG_FILE
    fi

    # Check for modified .htaccess file
    HTACCESS_FILE="/home/$USER/public_html/.htaccess"
    if [ -f "$HTACCESS_FILE" ]; then
        echo "Checking .htaccess file for suspicious redirects or malware..." >> $LOG_FILE
        suspicious_redirects=$(grep -i "Redirect" "$HTACCESS_FILE")
        suspicious_php_value=$(grep -i "php_value" "$HTACCESS_FILE")
        
        if [ ! -z "$suspicious_redirects" ] || [ ! -z "$suspicious_php_value" ]; then
            activity+="Suspicious entries found in .htaccess for user $USER.\n"
            compromised=true
        fi
    else
        echo "No .htaccess file found for user $USER." >> $LOG_FILE
    fi

    # Check for unauthorized access attempts in the secure log
    SECURE_LOG="/var/log/secure"
    if [ -f "$SECURE_LOG" ]; then
        echo "Checking /var/log/secure for unauthorized access attempts for user $USER..." >> $LOG_FILE
        unauthorized_ssh=$(grep "$USER" "$SECURE_LOG" | grep "Failed password")
        
        if [ ! -z "$unauthorized_ssh" ]; then
            activity+="Unauthorized SSH access attempts detected for user $USER.\n"
            compromised=true
        fi
    else
        echo "No secure log found." >> $LOG_FILE
    fi

    # Check for unusual WHM access
    WHM_LOG="/usr/local/cpanel/logs/access_log"
    if [ -f "$WHM_LOG" ]; then
        echo "Checking WHM logs for suspicious activity for user $USER..." >> $LOG_FILE
        suspicious_whm_login=$(grep "$USER" "$WHM_LOG" | grep "login failed")
        
        if [ ! -z "$suspicious_whm_login" ]; then
            activity+="Suspicious login attempts found in WHM logs for user $USER.\n"
            compromised=true
        fi
    else
        echo "No WHM log found." >> $LOG_FILE
    fi

    # If any suspicious activity is found, flag the account as compromised and send email alert
    if $compromised; then
        echo "Account $USER has been flagged as potentially compromised!" >> $LOG_FILE
        if [ "$PLUGIN_ENABLE_EMAIL_ALERTS" == "true" ]; then
            send_email_alert "$USER" "$activity"
        fi
    else
        echo "No suspicious activity detected for user $USER." >> $LOG_FILE
    fi
    echo "-----------------------------------" >> $LOG_FILE
done

echo "Scan completed!" >> $LOG_FILE
