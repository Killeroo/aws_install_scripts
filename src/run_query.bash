#!/bin/bash

# Arguments check
if [ $# -ne 2 ]; then
	echo "Not enough arguments:"
	echo "Usage: run_query.bash \"[Query]\" [DB]"
	exit
fi

# Switch back dir to read config file
cd .. 
source $PWD/setup.cnf
cd src/

# Write query to file
echo "$1" > $PWD/temp.sql

echo "> Executing \"$1\" @ [$2]..."

# Execute query by piping into mysql
mysql -u root -p$mysql_password $2 < $PWD/temp.sql

# Delete temp file
rm -f $PWD/temp.sql