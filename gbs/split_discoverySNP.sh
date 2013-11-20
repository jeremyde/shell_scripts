#!/bin/bash
#GBS analysis: Do DiscoverySNPCaller in batches with size set according to number of threads
INFILE="$1"
MERGEDFILE="$2"
OUTFILE="$3"
MNMAF="$4"
MNLCOV="$5"
REF="$6"
chromosome_start="$7"
chromosome_end="$8"
threads="$9"
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
    session="snpdiscover_$start_batch_$end_batch"
    echo "screen -d -m -S  $session  run_pipeline.pl -fork1 -DiscoverySNPCallerPlugin -i  $INFILE  -m  topm/cassava.topm.bin  -y -o  $OUTFILE -vcf -mnMAF $MNMAF -mnLCov $MNLCOV -ref $REF -sC $start_batch -eC $end_batch -inclRare -endPlugin -runfork1"
    screen -d -m -S "$session" run_pipeline.pl -fork1 -DiscoverySNPCallerPlugin -i "$INFILE" -m "topm/cassava.topm.bin" -y -o "$OUTFILE" -vcf -mnMAF "$MNMAF" -mnLCov "$MNLCOV" -ref "$REF" -sC "$start_batch" -eC "$end_batch" -inclRare -endPlugin -runfork1
    i=$(($i+1))
done
