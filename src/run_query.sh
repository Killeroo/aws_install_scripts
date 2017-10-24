#!/bin/bash

# Arguments check
if [ $# -ne 1 ]; then
	echo "Not enough arguments:"
	echo "Usage: run_query.sh \"[Query]\""
	exit
fi

mysql -u root -p -e $1