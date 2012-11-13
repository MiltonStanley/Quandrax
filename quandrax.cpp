/*
 * 
 * Title:        Quandrax
 * File:         Quandrax.cpp
 * Function:     Main program
 * Description:  The QUick ANd Dirty paRAdoX converter, a project to create 
 *               a single, unified save game converter.
 * Author:       Milton Stanley
 * Version:      1.1.0 - C++
 * License:      Too complicated. You can use this all you want. To edit it,
 *               you must do so through the Github page via pull requests, etc.
 *               at http://www.github.com/MiltonStanley/Quandrax_Cpp
 */
#include <iostream>
#include <string>
#include <vector>
#include <map>
#include "./include/player.h"
using namespace std;

/// CLASSES  ///

void test();


int main() {
  cout << "Starting Quandrax...\n\n";
  test();
  return 0;
}

void test(){
  cout << "Starting test...\n\n";
  Player me;

  map<string, string> tagMap;
  tagMap["d_normandy"] = "NRM";
  tagMap["k_england"] = "ENG";
  tagMap["e_scandinavia"] = "SCA";

  me.titles.push_back("d_normandy");
  me.titles.push_back("k_england");
  me.titles.push_back("e_scandinavia");
  me.id = 150;
  me.date = "1066.10.05";

  me.debug();
  me.convertToTags(tagMap);
  me.debug();
}


/*me = Player.new
me.titles = ['d_normandy','k_england','e_scandinavia']
me.date = "1066.10.05"
me.id = 150
prov = Province.new(1, 370, "NRM")

me.debug
me.convert_tags(TM_CK2_EU3)
me.debug
prov.debug


using namespace std;
  string line;
  ifstream oldFile("./tests/WilliamBeginning.ck2");
  while(getline(oldFile, line)){
    cout << line << endl;
  }
  oldFile.close();
*/