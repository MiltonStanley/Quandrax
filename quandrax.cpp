// Quandrax.cpp
#include <iostream>
#include "quandrax.h"

int main() {
  using namespace std;

  string line;
  ifstream myfile("WilliamBeginning.ck2");

  while(getline(myfile, line)){
    cout << line << endl;
  }

  myfile.close();

  return 0;
}

