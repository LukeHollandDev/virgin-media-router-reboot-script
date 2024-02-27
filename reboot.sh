#!/bin/bash

# Check if password is provided as command line argument
if [ $# -eq 0 ]; then
   echo "Please provide the password as a command line argument."
   exit 1
fi

# Set password
password=$1

# Login and retrieve token
login_response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"password\":\"$password\"}" http://192.168.0.1/rest/v1/user/login)
token=$(echo "$login_response" | grep -oE '"token":"[^"]+"' | cut -d':' -f2 | tr -d '"')

# Check if token is empty
if [ -z "$token" ]; then
   echo "Token not found in login response. Make sure password is correct."
   echo "Login response: $login_response"
   exit 1
fi

echo "Login successful, token: $token"

# Reboot system using the token
reboot_response=$(curl -s -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d '{"reboot": {"enable": true}}' http://192.168.0.1/rest/v1/system/reboot)

# Check if reboot request was successful
if [ $? -ne 0 ]; then
   echo "Reboot request failed. Please try again."
   echo "Reboot response: $reboot_response"
   exit 1
fi

# Print response
echo "Sent POST request to reboot router, response: $reboot_response"
