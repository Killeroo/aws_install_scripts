#!/bin/bash

# Stop mysql service
sudo systemctl stop mysql

# Setup new cluster
sudo galera_new_cluster

# Restart mysql
sudo systemctl start mysql

# Display cluster info
sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"