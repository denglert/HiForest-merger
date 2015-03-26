#include <TChain.h>
#include <TFile.h>
#include <iostream>
#include <stdlib.h>

using namespace std;

int mergeForest(char* fname = "/tmp/denglert/mergeReReco/pPb2013_minBias_HiForest*",char *outfile="/tmp/denglert/pPb2013_minBias_ReReco_run_210498-210658_merged.root")
{
     cout  << fname << endl;
   string dir[4] = {
    "hltanalysis",
    "skimanalysis",
    "pptracks",
    "hiEvtAnalyzer"
};


string trees[4] = {

    "HltTree",
    "HltTree",
    "trackTree",
    "HiTree",
};


   TChain* ch[4];

   int N = 4;

   for(int i = 0; i < N; ++i){
      ch[i] = new TChain(string(dir[i]+"/"+trees[i]).data());
      ch[i]->Add(fname);
      cout<<"Tree loaded : "<<string(dir[i]+"/"+trees[i]).data()<<endl;
      cout<<"Entries : "<<ch[i]->GetEntries()<<endl;
   }

   TFile* file = new TFile(outfile, "RECREATE");

   for(int i = 0; i < N; ++i){
      file->cd();
      cout <<string(dir[i]+"/"+trees[i]).data()<<endl;
      if (i==0) {
         file->mkdir(dir[i].data())->cd();
      } else {
         if (TString(dir[i].data())!=TString(dir[i-1].data()))
           file->mkdir(dir[i].data())->cd();
         else
           file->cd(dir[i].data());
      }
      ch[i]->Merge(file,0,"keep");
   }

   cout <<"Good"<<endl;
   //file->Write();
   file->Close();
   return 0;

}

int main(int argc, char *argv[])
{
  if((argc != 3))
  {
    std::cout << "Usage: mergeForest <input_collection> <output_file>" << std::endl;
    return 1;
  }

  int rStatus = -1;
  
  if(argc == 3)
    rStatus = mergeForest(argv[1], argv[2]);
  return rStatus;
}
