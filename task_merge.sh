#!/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Illegal number of parameters."
	echo "Usage: task_merge.sh <inputfilelistPATH> <outputDIR> <outputfilename>"
	exit 1
fi

inputfilelistPATH=$1
outputDIR=$2
outputfilename=$3

outputfilePATH="$2""/""$3"

echo "Hostname: $(hostname)"
echo -e "Directory: $(pwd)"
echo -e "Directory contents:\n $(ls -l)"

echo -e "Removing dir ./unmerged and its contents if existing" 
echo -e "Creating dir ./unmerged" 

rm -rf unmerged
mkdir unmerged

echo -e "Directory: $(pwd)"
echo -e "Directory contents:\n $(ls -l)"

# cmsStage. EOS -> lxbatch

for item in `cat $inputfilelistPATH`
do
	echo "Staging out $item to ./unmerged/ ..."
	cmsStage $item ./unmerged/
done

if [ "$?" = "0" ]; then
	echo -e "CHECK: Staging out finished." 
else
	echo -e "ERROR: Failed to stage out."
	rm -rf ./unmerged/ $outputfilename
	exit 1
fi

# Merging
$mergescriptPATH "./unmerged/*.root" $outputfilename

if [ "$?" = "0" ]; then
	echo -e "CHECK: Merge completed."
else
	echo -e "ERROR: Failed to merge."
	rm -rf ./unmerged/ $outputfilename
	exit 1
fi

# cmsStage. lxbatch -> EOS
cmsStage $outputfilename $outputDIR 

if [ "$?" = "0" ]; then
	echo -e "CHECK: Merged filed copied to EOS"
else
	echo -e "ERROR: Failed to copy the merged file to EOS"
	rm -rf ./unmerged/ $outputfilename
	exit 1
fi

# Deleting unmerged files and output merged file from the batch
rm -rf ./unmerged/ $outputfilename

if [ "$?" = "0" ]; then
	echo -e "Temporary folder ./unmerged/ and file $outputfilename are deleted." 
else
	echo -e "ERROR: Failed to delete."
fi

echo -e "Directory: $(pwd)"
echo -e "Directory contents:\n $(ls -l)"

echo -e "FINAL: Merge job completed for $outputfilename "
	echo $inputfilelistPATH
