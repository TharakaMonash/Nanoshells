#!/bin/bash
echo "#Sp    Energy" > spacing.log
list="0.4 0.5 0.6 0.7 0.8 0.9"
export OCT_PARSE_ENV=1 
for Spacing in $list 
do
 export OCT_Spacing=$(echo $Spacing*1.8897261328856432 | bc)
 octopus >& out-$Spacing
 energy=`grep Total static/info  | head -1 | cut -d "=" -f 2`
 echo $Spacing $energy  >> spacing.log
 rm -rf restart
done
unset OCT_Spacing