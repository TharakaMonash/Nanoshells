#!/bin/bash
# Use this script to generate the induced electron density on the z plane using the total electron densities.
for f in  ./output_iter/td.*/density.z\=0 ; do awk 'NR==FNR{a[NR]=$3;next}{if (NF != 0) print $1,$2,$3-a[FNR],$4 ; else print " " ;}' $f output_iter/td.0000000/density.z\=0 > "$f.diff" ;   done;