#ifndef PROVINCE_H
#define PROVINCE_H

#include <iostream>
#include <map>
#include <string>
#include <vector>

using namespace std;

class Province {
 public:
  int oldID;
  vector<int> newID;
  string controller;
  Province(int _oldID, int _newID, string controller);
  ~Province(){};
  void newController(string _newController);
  void debug(bool printHeaders);
};

#endif
