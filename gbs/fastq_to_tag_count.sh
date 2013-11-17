#!/bin/bash
#GBS analysis: Do FastqToTagCount for each subdirectory in specified directory 
#starting each under screen
FILEDIR="$1"
FILES="$FILEDIR*"
OUTDIR="$2"
KEYFILE="$3"
enzyme="$4"
echo "running commands:"
for f in $FILES
do
    filename=$(basename "$f")
    echo "screen -d -m -S $filename run_pipeline.pl -fork1 -FastqToTagCountPlugin -i $f -o $OUTDIR -k $KEYFILE -e $enzyme -endPlugin -runfork1" 
    screen -d -m -S "$filename" run_pipeline.pl "-fork1 -FastqToTagCountPlugin -i $f -o $OUTDIR -k $KEYFILE -e $enzyme -endPlugin -runfork1"
done
