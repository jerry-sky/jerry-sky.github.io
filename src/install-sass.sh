#!/bin/bash

archive="sass.tar.gz"

cd /bin

# download the archive containing the executable
curl -L --output "$archive" 'https://github.com/sass/dart-sass/releases/download/1.32.8/dart-sass-1.32.8-linux-x64.tar.gz'

# unpack the archive
tar -x 'dart-sass/sass' --strip-components=1 -f "$archive"

# remove the archive
rm "$archive"
