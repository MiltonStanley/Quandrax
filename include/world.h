//world.h
#ifndef WORLD_H
#define WORLD_H

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "province.h"

using namespace std;

class World{
 public:
  string game;
  vector<Province> self;
  World(string _game){ game = _game;}
  ~World(){};
  void create(vector<int> provinceMap, vector<string> controllerList);
  void debug();
};


#endif