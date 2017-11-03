#!/bin/bash

# Interupter check
[[ $_ != $0 ]] && sourced=1 || sourced=0
if [ $sourced -ne 1 ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@     PLEASE RUN SCRIPT WITH BASH!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

# Root check
if [[ $EUID -ne 0 ]]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	echo "@@       PLEASE RUN SCRIPT AS ROOT!      @@"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit;
fi

echo "-> Creating test data..."
sudo bash ./src/tests/create_test_data.bash
sudo bash ./src/tests/view_test_data.bash
echo "-> Test complete."
echo "[ Run ./src/tests/remove_test_data.bash to remove ]"