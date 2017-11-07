#!/bin/bash

sudo bash ./src/service_controller.bash mysql stop

echo "> Starting Galera Node..."

sudo bash ./src/service_controller.bash mysql start