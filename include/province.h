#ifndef PROVINCE_H
#define PROVINCE_H

#include <iostream>
#include <map>
#include <string>
#include <vector>

using namespace std;

class Province {
 public:
  string oldID;
  string newID;
  string controller;
  Province(string _oldID, string _newID, string controller);
  ~Province(){};
  void newController(string _newController);
  void debug();
};

#endif