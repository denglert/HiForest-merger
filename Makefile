########################
# ===== Datasets ===== #
########################

# === pPb2013_HM_28Sep2013_Pb === #
#jobtag = pPb2013_HM_28Sep2013_pPb 
#inputlist = pPb2013_HM_28Sep2013_pPb.txt 
#outputDIR = /store/group/phys_heavyions/denglert/pPb2013_HighMultiplicityForest_merged/HIRun2013-28Sep2013-v1_pPb_run_210498-210658/ 
#outputfilebase = pPb2013_HM_28Sep2013_v1_HiForest_pPb_run_210498-210658 

# === pPb2013_HM_PromptReco_pPb === #
jobtag 			= pPb2013_HM_PromptReco_pPb
inputlist 		= pPb2013_HM_PromptReco_pPb.txt 
outputDIR 		= /store/group/phys_heavyions/denglert/pPb2013_HighMultiplicityForest_merged/HIRun2013-PromptReco-v1_pPb_run_210676-211256 
outputfilebase = pPb2013_HM_PromptReco-v1_HiForest_pPb_run_210676-211256

# === pPb2013_HM_PromptReco_Pbp === # 
#jobtag 			 = pPb2013_HM_PromptReco_Pbp 
#inputlist 		 = pPb2013_HM_PromptReco_Pbp.txt
#outputDIR 		 = /store/group/phys_heavyions/denglert/pPb2013_HighMultiplicityForest_merged/HIRun2013-PromptReco-v1_Pbp_run_211313-211631/
#outputfilebase = pPb2013_HM_PromptReco-v1_HiForest_Pbp_run_211313-211631

# Options
compression = 5
queue = 1nd

environmentDIR=/afs/cern.ch/work/d/denglert/public/projects/PKPCorrelation_SLC6/CMSSW_5_3_20/src/denglert/PKPCorrelationAna
mergescriptPATH=/afs/cern.ch/work/d/denglert/public/util/hiForestMerging/lxbatch/mergeForest.exe

# Export Makefile variables to shell environment
export jobtag inputlist outputDIR outputfilebase compression queue environmentDIR mergescriptPATH

############################################################
all :

submit : 
	./submit_mergejobs.sh

merge_list :
	./merge_list.sh

clean :
	rm -rf $(jobtag)
