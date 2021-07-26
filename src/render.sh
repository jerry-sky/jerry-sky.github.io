#!/bin/bash

SRC_DIR="${BASH_SOURCE%/*}"
WRK_DIR="${SRC_DIR%/*}"

# environment: root repository directory
cd $WRK_DIR

# prepare the output directory
mkdir -p dist
cp -r assets dist/

# render the css
$SRC_DIR/sass template/style.scss > dist/style.css

# prepare the renderer
renderer="$SRC_DIR/pandoc \
    --template template/document-template.html \
    --from markdown-blank_before_header-implicit_figures+lists_without_preceding_blankline+gfm_auto_identifiers \
    --to html \
    --standalone \
    --css /style.css \
    -H template/head.html"

# prepare the background file
background="/tmp/background.html"
# how many particles to generate
particle_quantity=50
# wipe the file clean
printf '' > "$background"
for j in one two; do
    for i in slow medium fast; do
        printf '<div class="background '$i" "$j'">' >> "$background"
        yes '<div class="background-particle"></div>' | head -n "$particle_quantity" >> "$background"
        printf '</div>\n' >> "$background"
    done
done

# render the main index file
$renderer public/index.md -o dist/index.html --include-before-body="$background"
