#!/bin/bash

test=$(fetch_password.sh mysql)

echo
echo $test 
echo

# Show mysql/maria/galera service status
sudo systemctl --no-pager --lines=0 status mysql

# Show cluster status
sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"