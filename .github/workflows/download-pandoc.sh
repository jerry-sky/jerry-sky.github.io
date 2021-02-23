#!/bin/bash

archive="pandoc.tar.gz"

# download the archive containing the executable
curl -L --output "$archive" 'https://github.com/jgm/pandoc/releases/download/2.11.4/pandoc-2.11.4-linux-amd64.tar.gz'

# unpack the archive
tar -x 'pandoc-2.11.4/bin/pandoc' --strip-components=2 -f "$archive"

# remove the archive
rm "$archive"

# get the current directory
cur_dir="${BASH_SOURCE%/*}"

# get the target directory
target="$1"

if [ -z "$target" ]; then
    # default value is the current directory
    target="."
fi

# strip the forward slash at the end if present
target="${target%/}"

# move the extracted executable to the target directory
mv "$cur_dir/pandoc" "$target"

