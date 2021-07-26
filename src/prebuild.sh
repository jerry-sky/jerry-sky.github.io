#!/bin/bash

SRC_DIR="${BASH_SOURCE%/*}"

# environment: source directory
cd $SRC_DIR
# download Sass and Pandoc if necessary
if [ ! -f pandoc -o ! -f sass ]; then
    ./download-pandoc.sh
    ./download-sass.sh
fi
