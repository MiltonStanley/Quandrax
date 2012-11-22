//world.cpp

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "./include/province.h"
#include "./include/world.h"

using namespace std;

template<class T>

void World<T>::create(const int classMap[], string controllerList[]){
  
  cout << "creating!" << endl;
}

template<class T>
void World<T>::debug(){
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