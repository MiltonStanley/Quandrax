/* 
 *  Quandrax
 *  The Quick and Dirty Paradox Converter
 *  Version 1.1.0
 *  (c) 2012 Milton Stanley
 *
 */

#include <iostream>
#include <fstream>
//#include "player.h"
//#include "province.h"
#include "header.h"

using namespace std;

int main() {
  cout << "Starting Quandrax...\n";
  
/*  using namespace std;
  string line;
  ifstream oldFile("./tests/WilliamBeginning.ck2");
  while(getline(oldFile, line)){
    cout << line << endl;
  }
  oldFile.close();
*/

  Header CK2;
  CK2.SetDate("1066.10.01");
  cout << "The date is " << CK2.GetDate() << endl;
  return 0;
}

void Header::SetDate(string newDate_){
  date = newDate_;
}

string Header::GetDate() const {
  return date;
}