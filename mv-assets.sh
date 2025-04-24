#!/bin/bash
for f in `find assets/ -type f -name '*.png'`
do
  filename="${f%.*}"
  magick $f -quality 86 $filename.jpg
  rm $f
done
