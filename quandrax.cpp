/* 
 *  Quandrax
 *  The Quick and Dirty Paradox Converter
 *  Version 1.1.0
 *  (c) 2012 Milton Stanley
 *
 */

#include <iostream>
#include <string>
//#include <fstream>

using namespace std;
// MY CLASSES 

const TEST_TITLES = 1;

void test();

class Player {
 public:
  string titles[1];
  string date;
  int id;
  void SetTitle(int, string);
  void debug();
};

void Player::SetTitle(int title, string new_title){
  titles[title] = new_title;
}

void Player::debug(){
    cout << "Player: " << titles[0] << endl;
    cout << id << endl;
    cout << "Date: " << date << endl;
    //int number_of_titles = titles.length;
    //cout << number_of_titles << endl;
    /*
    for (i=0; i<3; i++) {
      cout << i << endl;
    }*/

  }

/*

class Player
  attr_accessor :titles, :date, :id
  
  def debug
    puts "Player: #{@titles[0]}"
    puts "ID: #{@id}"
    puts "Date: #{@date}"
    puts @titles.join(', ')
  end
  
  def convert_tags(tag_map)
    @titles.each_index do |title|
      @titles[title] = tag_map[@titles[title]]
    end
  end

end
*/

int main() {
  cout << "Starting Quandrax...\n\n";
  test();
  return 0;
}

void test(){
  cout << "Starting test...\n\n";
  Player me;

  me.SetTitle(0, "d_normandy");
  me.id = 150;
  me.date = "1066.10.05";

  //me.titles[] = { "d_normandy", "k_england","e_scandinavia" };
  me.debug();
}


/*me = Player.new
me.titles = ['d_normandy','k_england','e_scandinavia']
me.date = "1066.10.05"
me.id = 150
prov = Province.new(1, 370, "NRM")

me.debug
me.convert_tags(TM_CK2_EU3)
me.debug
prov.debug


using namespace std;
  string line;
  ifstream oldFile("./tests/WilliamBeginning.ck2");
  while(getline(oldFile, line)){
    cout << line << endl;
  }
  oldFile.close();
*/