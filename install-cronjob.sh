#!/bin/bash

path=$(pwd)

(crontab -l ; echo "* * * * * $(pwd)/update-production.sh") | crontab -


