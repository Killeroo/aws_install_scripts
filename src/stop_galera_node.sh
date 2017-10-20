#!/bin/bash

# Stop service
sudo systemctl stop mysql

# Show mysql/maria/galera service status
sudo systemctl --no-pager --lines=0 status mysql