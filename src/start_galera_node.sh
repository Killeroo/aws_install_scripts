#!/bin/bash

# Stop mysql service
sudo systemctl stop mysql

# Restart mysql
sudo systemctl start mysql

# Display cluster info
sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"