# mariadb_galera_install_scripts
A set of Bash scripts for setting up a mariadb galera cluster on blank Ubuntu machine or instance

Order to run

1) install_mariadb_galera_cluster_base.sh (node_num) (node_address)
2) setup_galera_config.sh (node_address_1) (node_address_2) (node_address_3)
3) - Main node: start_galera_cluster.sh
   - Other nodes: start_galera_node.sh

For testing:

1) create_test_data.sh
2) (on other nodes) view_test_data.sh
3) remove_test_data.sh
(optional) add_test_data.sh [name] [second name] [age]

