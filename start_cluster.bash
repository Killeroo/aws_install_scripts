#!/bin/bash

# Stop mysql service
sudo bash ./src/service_controller.bash mysql stop

# Setup new cluster
echo "> Starting new Galera Cluster..."
sudo galera_new_cluster

# Restart mysql service
sudo bash ./src/service_controller.bash mysql start