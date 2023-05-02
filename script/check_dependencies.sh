#!/bin/bash

# Function to check if a command is available
check_command() {
    if command -v $1 >/dev/null 2>&1; then
        echo "$1 is installed and available."
    else
        echo "$1 is not installed or not in system's PATH."
    fi
}

# Check for ngrok
check_command "ngrok"

# Check for msfconsole
check_command "msfconsole"

# Check for msfvenom
check_command "msfvenom"

# Check for whiptail
check_command "whiptail"

# Check for jq
check_command "jq"


