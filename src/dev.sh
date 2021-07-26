#!/bin/bash

SRC_DIR="${BASH_SOURCE%/*}"
WRK_DIR="${SRC_DIR%/*}"


# clean up after exit
function finish() {
    kill 0
}
trap finish EXIT


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


# environment: root repository directory
cd $WRK_DIR

# prepare
$SRC_DIR/prebuild.sh

RENDER="$SRC_DIR/render.sh"

# initialise
$RENDER

# keep rebuilding on every file change
(
    inotifywait \
        -mr public \
        -e MODIFY \
        -e CREATE \
        -e DELETE \
        | while read c; do
            echo "$c"
            $RENDER
        done
) &

# refresh browser on every change
httpwatcher \
    --root dist \
    --host "${HOST:-localhost}" \
    --port 4200 \
    --no-browser
