#!/bin/bash
#Create a subdirectory for each file in a directory and move the file into its subdirectory
FILEDIR="$1"
FILES="$FILEDIR*"
for f in $FILES
do
  filename=$(basename "$f")
  dirname=$(dirname "$f")
  mkdir "$dirname/dir_$filename"
  mv "$f" "$dirname/dir_$filename/"
done
