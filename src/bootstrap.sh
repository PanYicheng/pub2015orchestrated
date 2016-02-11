#!/bin/sh

# Regenerates the monitor file "rf1.pat" which 
# stores the four different selective subpopulations.

# Load global vars such as OUTDIR
. ./globalvars.sh

# Leave unchanged in most cases
T_START=3000
T_STOP=3500

echo "Running first leg of simulation to determine neuron selectivity."
./1run_init.sh

echo "Generating trigger file"
./scripts/mktrigfile.awk $OUTDIR/rf1.0.stimtimes > data/rf1.trig

echo "Create merged ras file from files from different ranks "
sort -g -m $OUTDIR/rf1.*.e.ras > $OUTDIR/rf1.e.ras

echo "Computing PSTH..."
scripts/rassta.py -t data/rf1.trig -w 0.5 -f $OUTDIR/rf1.e.ras -s $T_START -m $T_STOP -q 0.0 -o data/rf1.sta

echo "Generating pattern file..."
scripts/sta2pat.sh data/rf1.sta data/rf1.pat
echo "done"
