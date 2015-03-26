# HiForest-merger
merge HiForest on CMS-EOS

Makefile

Steps:
1, Specify the following fields:
- jobtag = Name of the job directory
- inputlist = ASCI file with the list of input .root files in it
- outputDIR = Output directory on EOS
- outputfilebase = output files' base name

- compression = Compression level
- queue = lxbatch queue

- mergescriptPATH = Specify the mergescript binary (mergeForest.exe)

2, Generate merge file lists by:
make merge_list

3, Check the file lists in the 'jobtag' directory

4, If everything looks good, submit the merging jobs by:
make submit
