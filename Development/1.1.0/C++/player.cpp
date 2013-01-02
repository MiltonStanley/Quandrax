#include <iostream>
#include <map>
#include <string>
#include <vector>
#include "./include/player.h"

using namespace std;


void Player::debug(){
  cout << "Player: " << titles.front() << endl;
  cout << "ID: " << id << endl;
  cout << "Date: " << date << endl;
  for(vector<string>::iterator i = titles.begin(); i<titles.end(); i++){
    cout << *i;
    if(i < (titles.end()-1)) /* then */ cout << ", ";
  }
  cout << endl;
}

void Player::convertToTags(map<string,string> tagMap){
  cout << "Converting to tags..." << endl;
  for(unsigned int i=0; i<titles.size(); i++)
    titles[i] = tagMap[titles[i]];
}