#!/bin/bash
# This script can be used to generate the squared projections from projections.
awk {'
if(NR>22){
	for (i=3; i <= NF; i+=2) {
		printf "%f  \t", (($i*$i)+($(i+1)*$(i+1)));
	}
	printf "\n" 
}} ' td.general/projections > sqr_projections