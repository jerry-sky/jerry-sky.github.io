#!/bin/bash

# clean up after exit
function finish() {
    kill 0
}
trap finish EXIT


SRC_DIR="${BASH_SOURCE%/*}"
DIR="${SRC_DIR%/*}"

# environment: root repository directory
cd $DIR

# validate environment
if [ $(find . -type d | egrep -c -- 'src|public') -ne 2 ]; then
    printf '\033[1m%s\033[0m\n' 'directory structure is invalid'
    exit 1
fi

# check if necessary tools are installed
command -v inotifywait >/dev/null
if [ "$?" -ne 0 ]; then
    printf '\033[1m%s\033[0m\n' 'you need to have the `inotify-tools` package installed' >&2
    exit 1
fi

command -v httpwatcher >/dev/null
if [ "$?" -ne 0 ]; then
    printf '\033[1m%s\033[0m\n' 'you need to have the `httpwatcher` Python package installed' >&2
    printf '%s\n' 'try running `python3 -m pip install httpwatcher`' >&2
    exit 1
fi

# the default build script
BUILD="$SRC_DIR/build.sh"

# initialise
$BUILD

# keep rebuilding on every file change
(
    inotifywait \
        -mr public \
        -e MODIFY \
        -e CREATE \
        -e DELETE \
        | while read c; do
            echo "$c"
            $BUILD
        done
) &

# refresh browser on every change
httpwatcher \
    --root dist \
    --host "${HOST:-localhost}" \
    --port 4200 \
    --no-browser

if [ $? -eq 143 ]; then
    exit 0
fi
