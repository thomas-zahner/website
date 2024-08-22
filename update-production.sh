#!/bin/bash

git pull origin master --recurse-submodules
git submodule update --init --recursive
zola build
