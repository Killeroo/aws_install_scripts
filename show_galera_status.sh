#!/bin/bash

# Show mysql/maria/galera service status
sudo systemctl status mysql

# Show cluster status
sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
