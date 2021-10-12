#!/bin/sh
output=${1%.*}
cwebp -q 90 $1 -o temp.webp
convert temp.webp -resize 1000x $output.webp
rm temp.webp
