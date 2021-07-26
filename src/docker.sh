#!/bin/bash

# non-root user UID:GID
uid=${uid:-"1000"}
gid=${gid:-"1000"}

SRC_DIR="${BASH_SOURCE%/*}"

apt-get update
apt-get install -y curl

# install file watcher package
apt-get install -y inotify-tools

# create a user without a password
addgroup --gid "$gid" user
adduser --disabled-password --gecos '' --uid "$uid" --gid "$gid" user

# run as a non-root user
su - user $1
