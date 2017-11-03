#!/bin/bash

mysql -u root -p -e '
CREATE DATABASE IF NOT EXISTS test_db;
CREATE TABLE IF NOT EXISTS test_db.people (id INT NOT NULL AUTO_INCREMENT, fname VARCHAR(25), sname VARCHAR(25), age INT, PRIMARY KEY(id));
INSERT INTO test_db.people (fname, sname, age) VALUES ("Trent", "Reznor", 52);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Stephen", "Carpenter", 47);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Chino", "Moreno", 44);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Linus", "Torvalds", 47);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Les", "Claypol", 52);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Larry", "LaLonde", 49);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Jeremy", "Benthan", 269);
INSERT INTO test_db.people (fname, sname, age) VALUES ("Mike", "Patton", 49);'
