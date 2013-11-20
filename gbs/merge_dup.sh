#!/bin/bash
#GBS analysis: Do MergeDuplicateSNPs in batches with size set according to number of threads
INFILE="$1"
OUTFILE="$2"
chromosome_start="$3"
chromosome_end="$4"
threads="$5"
chromosome_count=$((1+$chromosome_end-$chromosome_start))
#calculate batch size by rounding up count/threads
batch_size=$((($chromosome_count+($threads-1))/$threads))
let i=0
echo "Running commands:"
while [ $i -lt $threads ]
do
    start_batch=$(($chromosome_start+$i*$batch_size))
    end_batch=$(($start_batch+$batch_size-1))
    if [ $end_batch -gt $chromosome_end ]
    then
	end_batch=$chromosome_end
    fi
    session="merge_dup_$start_batch_$end_batch"
    echo "screen -d -m -S $session run_pipeline.pl -fork1 -MergeDuplicateSNPsPlugin -vcf $INFILE -o $OUTFILE -sC $start_batch -eC $end_batch -endPlugin -runfork1"
    screen -d -m -S "$session" run_pipeline.pl -fork1 -MergeDuplicateSNPsPlugin -vcf "$INFILE" -o "$OUTFILE" -sC "$start_batch" -eC "$end_batch" -endPlugin -runfork1
    #echo "run_pipeline.pl -fork1 -MergeDuplicateSNPsPlugin -vcf $INFILE -o $OUTFILE -sC $start_batch -eC $end_batch -endPlugin -runfork1"
    i=$(($i+1))
done
