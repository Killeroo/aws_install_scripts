#!/bin/bash

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@      PLEASE RUN SCRIPT WITH BASH      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@        PLEASE RUN SCRIPT AS ROOT      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

# Check file exists
if [ ! -f /var/lib/mysql/grastate.dat ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@        GRASTATE.DAT NOT FOUND!        @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "Make sure MariaDB galera is installed correctly "
	echo "and /var/lib/mysql/grastate.dat exists, then try again."
	echo
	exit;
fi

sed -i "s|safe_to_bootstrap:.*|safe_to_bootstrap: 1|" /var/lib/mysql/grastate.dat
echo "> Enabled safe_to_bootstrap"