#!/bin/bash
for f in `find content/ -type f -name '*.jpg'`
do
  mv $f assets/
done
