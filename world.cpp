//world.cpp

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "./include/world.h"

using namespace std;

void World::create(const int provinceMap[], string controllerList[]){
  
  cout << "creating!" << endl;
}

void World::debug(){
  cout << "<-- Start World debugging! -->" << endl;
  cout << "Game type: " << game << endl;
  //for(int i=0; i<size; i++)
  cout << this << endl;
  cout << "debugging!" << endl;
}
/*
    puts "<-- Start World debugging! -->"
    puts "Game type: #{@game}"
    self.each do |province|
      next if province.nil?
      province.debug(false)
    end
    puts "<--  End World debugging!  -->"
*/