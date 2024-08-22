#!/bin/bash

git pull origin master --recurse-submodules
git submodule update --init --recursive
zola build

# since zola temporarily deletes the directory mounted directory is no longer accessible from within running Docker containers.
# maybe there could be a better work-around or fix?
sudo docker compose down
sudo docker compose up -d
