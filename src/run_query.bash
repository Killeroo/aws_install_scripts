#!/bin/bash

# Arguments check
if [ $# -ne 2 ]; then
	echo "Not enough arguments:"
	echo "Usage: run_query.bash \"[Query]\" [DB]"
	exit
fi

mysql -u root -p -e $1 $2