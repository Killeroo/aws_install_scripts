#!/bin/bash

# Takes mysql or account argument

# Fetch password from conf file
grep 'password=' passwords.conf | awk -F= '{ print  $2 }'