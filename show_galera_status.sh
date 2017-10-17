#!/bin/bash

password=$(bash $PWD/fetch_password.sh mysql)

expect $PWD/enter_password.exp $password $command 

# Show mysql/maria/galera service status
sudo systemctl --no-pager --lines=0 status mysql

# Show cluster status
#sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"