//province.cpp

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "./include/province.h"

using namespace std;

Province::Province(string _oldID, string _newID, string _controller){
	oldID = _oldID;
	newID = _newID;
	controller = _controller;
}

void Province::newController(string _newController){
	controller = _newController;
}

void Province::debug(){
	cout << "Province " << oldID << " => " << newID << ", controller: " 
																										 << controller << endl;
}