#!/bin/bash

cur_dir="${BASH_SOURCE%/*}"

exe="$cur_dir/pandoc"

# make sure the executable is there
if [ ! -f "$exe" ]; then
    echo "no executable found, download Pandoc first"
    exit 1
fi

# prepare the output directory
mkdir -p dist
cp -r assets dist/
cp template/style.css dist/

# prepare the renderer
renderer="$exe --template template/document-template.html --from markdown-blank_before_header-implicit_figures+lists_without_preceding_blankline+gfm_auto_identifiers --to html --standalone --css style.css -H template/head.html"

# render the main readme file
$renderer readme.md --output dist/index.html
