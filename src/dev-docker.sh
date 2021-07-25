#!/bin/bash

# (Debian, Buster)

WRK_DIR=$(pwd)

apt-get update
apt-get install -y curl

# install file watcher package
apt-get install -y inotify-tools

# create a user without a password
adduser --disabled-password --gecos '' user
# switch to it
su - user <<EOF
cd $WRK_DIR

# add local installation binaries to PATH
PATH="/home/\$USER/.local/bin:\$PATH"

# install Python watcher package
python3 -m pip list | grep httpwatcher || python3 -m pip install httpwatcher

bash $1
EOF

