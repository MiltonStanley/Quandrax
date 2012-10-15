// Quandrax.cpp
#include <iostream>
#include "quandrax.h"

int main() {
  using namespace std;

  string line;
  ifstream oldFile("WilliamBeginning.ck2");

  while(getline(oldFile, line)){
    cout << line << endl;
  }

  oldFile.close();

  return 0;
}