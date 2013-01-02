#include <iostream>
#include <string>
#include <vector>
#include <map>

using namespace std;

void convertToTags(vector<string> &, map<string, string>);

int main(){
  vector<string> titles;
  titles.push_back("d_normandy");
  titles.push_back("k_england");
  titles.push_back("e_scandinavia");

  map<string, string> tagMap;

  tagMap["d_normandy"] = "NRM";
  tagMap["k_england"] = "ENG";
  tagMap["e_scandinavia"] = "SCA";

  for(int i=0;i<titles.size();i++) 
    cout << "Title " << i << ": " << titles[i] << endl;

  convertToTags(titles, tagMap);


  for(int i=0;i<titles.size();i++) 
    cout << "Title " << i << ": " << titles[i] << endl;


  

  return 0;
}

void convertToTags(vector<string> & titles, map<string,string> tagMap){
  cout << "Converting to tags..." << endl;
  for(int i=0; i<titles.size(); i++){
    titles[i] = tagMap[titles[i]];
  }
}