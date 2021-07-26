#!/bin/bash

SRC_DIR="${BASH_SOURCE%/*}"

# add local installation binaries to PATH
PATH="/home/$USER/.local/bin:$PATH"

# install Python watcher package if it is not installed
python3 -m pip list | grep httpwatcher || python3 -m pip install httpwatcher

# run standard dev script
$SRC_DIR/dev.sh
