#!/bin/bash

SRC_DIR="${BASH_SOURCE%/*}"

# environment: source directory

$SRC_DIR/prebuild.sh
$SRC_DIR/render.sh
