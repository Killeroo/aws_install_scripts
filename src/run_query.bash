#!/bin/bash

# Arguments check
if [ $# -ne 2 ]; then
	echo "Not enough arguments:"
	echo "Usage: run_query.bash \"[Query]\" [DB]"
	exit
fi

# Switch back dir to read config file
cd .. & source $PWD/setup.cnf

# Write query to file
echo $1 > $PWD/temp.sql

# Execute query by piping into mysql
mysql -u root -p$mysql_password < $PWD/temp.sql

# Delete temp file
rm $PWD/temp.sql

# Switch back
cd src/