#!/bin/bash

bash $PWD/fetch_password.sh mysql

# Show mysql/maria/galera service status
sudo systemctl --no-pager --lines=0 status mysql

# Show cluster status
sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"