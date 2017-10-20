# mariadb_galera_install_scripts
A set of Bash scripts for setting up a mariadb galera cluster on blank Ubuntu machine or instance

To install galera run:

`sudo bash install.sh [node_num] [node_ip] [cluster_addresses]`

To test cluster:

`sudo bash test.sh`

To start and stop node:

`sh start.sh`

and

`sh stop.sh`

For current galera status use

`sudo bash status`