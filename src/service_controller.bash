#!/bin/bash
# Used to control php and nginx services

# Arguments check
if [ $# -ne 2 ]; then
	echo "USAGE: service_controller.bash [ mysql ] [ start | stop | restart | reload ]";
	exit;
fi

# Validate operator argument
valid_operators=( "start" "stop" "restart" "reload" )
if [[ " ${valid_operators[*]} " == *" $2 "* ]]; then
	operator=$2
else
	echo "UNKOWN ARGUMENT: Use either [ start | stop | restart | reload ] "
	exit
fi

# Perform service operation
if [ $1 = "mysql" ]; then
	sudo systemctl $operator mysql
else
	echo "UNKOWN ARGUMENT: Use either [ mysql ] "
	exit;
fi

echo "> Service [$1] told to [$2]..."