#!/bin/sh
# submit_mergejobs.sh

# Compile the merge code
g++ mergeForest.C $(root-config --cflags --libs) -Werror -Wall -O2 -o mergeForest.exe || exit 1

cp task_merge.sh $jobtag/task_merge.sh

cd $jobtag
currDIR=$(pwd)

echo -e "Job directory: $jobtag"

for f in *.txt; do

	inputfilelistPATH=${currDIR}/$f
	filebasename=${f%.*}
	outfilename="${filebasename}.root"

	bsub -q $queue -J $jobtag task_merge.sh $inputfilelistPATH $outputDIR $outfilename
done

bjobs
