#!/bin/bash
# Use this script to generate the induced electron density from the total electron densities.
mkdir densityPlot
for f in ./output_iter/td.*/density.y* ; do cat ./densityPlot/temp | paste - $f >./densityPlot/tempq; cp ./densityPlot/tempq ./densityPlot/temp; done; rm ./densityPlot/tempq
awk  '{DL=""; for (i=2;i<=NF;i+=2) {printf "%s%s", DL, $i; DL="\t"}; printf "\n" }' ./densityPlot/temp >./densityPlot/temp1
awk 'NR > 1 { print }' ./densityPlot/temp1 > ./densityPlot/density
cp ./td.general/laser ./densityPlot/laser1
awk 'NR > 6 { print }' ./densityPlot/laser1 > ./densityPlot/laser
rm -rf ./densityPlot/temp1 ./densityPlot/temp ./densityPlot/laser1
