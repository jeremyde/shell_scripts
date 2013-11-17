#!/bin/bash
#GBS analysis: Do FastqToTBT for each subdirectory in specified directory
FILEDIR="$1"
FILES="$FILEDIR*"
OUTDIR="$2"
KEYFILE="$3"
enzyme="$4"
TAGFILE="$5"
echo "Running commands:"
for f in $FILES
do
    filename=$(basename "$f")
    echo "screen -d -m -S $filename  run_pipeline.pl -fork1 -FastqToTBTPlugin -i $f -o $OUTDIR -k $KEYFILE -y -e apeki -t $TAGFILE -endPlugin -runfork1"
    screen -d -m -S "$filename"  run_pipeline.pl -fork1 -FastqToTBTPlugin -i $f -o $OUTDIR -k $KEYFILE -y -e apeki -t $TAGFILE -endPlugin -runfork1
done
