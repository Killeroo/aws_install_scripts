#!/bin/bash

# Takes mysql or account argument

# Check if bash (shell) or sh (subshell) is running script
[[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"


# Arguments check
if [ $# -ne 1 ]; then
	echo "Incorrect argument count:"
	echo "fetch_password [mysql] OR [general]"
	exit
fi
# Check password.conf exists
# Check password.conf passwords is not empty

# Fetch password from conf file
grep 'password=' $PWD/password.conf | awk -F= '{ print  $2 }'