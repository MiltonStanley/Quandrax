#ifndef PLAYER_H
#define PLAYER_H

#include <iostream>
#include <map>
#include <string>
#include <vector>

using namespace std;

class Player {
 public:
  vector<string> titles;
  string date;
  int id;
  void debug();
  void convertToTags(map<string, string>);
};

#endif