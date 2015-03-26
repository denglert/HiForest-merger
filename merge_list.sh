#!/bin/sh
# merge_list.sh

rm -rf $jobtag
mkdir $jobtag

ninputfiles=`cat $inputlist | wc -l`

log="./$jobtag/log"
touch $log

# Number of input files
echo "Number of input files: $ninputfiles"
echo "Compression: $compression"

echo "Lxbatch job submission log." >> $log
echo "Tag: $jobtag" >> $log
echo "Inputfilelist: $inputlist" >> $log
echo "Output DIR: $outputDIR" >> $log
echo "Output filebase: $outputfilebase" >> $log 
echo "Number of files in the main inputfilelist: $ninputfiles" >> $log
echo "Number of merged output files: $noutputfiles"  >> $log

# Number of output files

if (( ( ${ninputfiles} % ${compression} ) != 0 ))
then
	echo "Number of files is not a multiple of compression."
	noutputfiles=$((1+$ninputfiles/$compression))
else
	noutputfiles=$(($ninputfiles/$compression))
fi

from=1
to=$compression

for (( i = 0; i < ($noutputfiles); i++ )); do

	echo "Index: $i"

	jobfilelist="$(pwd)/${jobtag}/${outputfilebase}_${i}.txt"

	files=$(awk "NR>=$from&&NR<=$to" $inputlist)
	echo "$files" > $jobfilelist
	cat $jobfilelist

	from=$from+$compression
	to=$to+$compression
done
