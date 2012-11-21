//world.h
#ifndef WORLD_H
#define WORLD_H

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "province.h"

using namespace std;

class World:public Array {
 public:
  string game;
  int size;
  vector<Province> self;
  World(string _game){ game = _game;}
  ~World(){};
  void create(const int provinceMap[], string controllerList[]);
  void debug();
};


#endif