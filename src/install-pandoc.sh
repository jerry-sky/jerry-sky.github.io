#!/bin/bash

archive="pandoc.tar.gz"

cd /bin

# download the archive containing the executable
curl -L --output "$archive" 'https://github.com/jgm/pandoc/releases/download/2.11.4/pandoc-2.11.4-linux-amd64.tar.gz'

# unpack the archive
tar -x 'pandoc-2.11.4/bin/pandoc' --strip-components=2 -f "$archive"

# remove the archive
rm "$archive"
