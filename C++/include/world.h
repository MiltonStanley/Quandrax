//world.h
#ifndef WORLD_H
#define WORLD_H

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "province.h"

using namespace std;

template<class T>
class World : public vector<T> {
 public:
  string game;
  int size;
  World(string _game){ game = _game;}
  ~World(){};
  void create(){
  	cout << "Creating!\n";
  };//(const int provinceMap[], string controllerList[]);
  void debug(){
  	cout << "Debugging!\n";
  	  };
};



#endif
