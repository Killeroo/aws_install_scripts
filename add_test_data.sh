#!/bin/bash

# Arguments check
if [ $# -lt 3 ] || [ $# -gt 3 ]; then
	echo "Not enough arguments: script [fname] [sname] [age]";
	exit;
fi

mysql -u root -p -e "
CREATE DATABASE IF NOT EXISTS test_db;
CREATE TABLE IF NOT EXISTS test_db.people (id INT NOT NULL AUTO_INCREMENT, fname VARCHAR(25), sname VARCHAR(25), age INT, PRIMARY KEY(id));
INSERT INTO test_db.people (fname, sname, age) VALUES (\"$1\", \"$2\", $3);"