// player.h

using namespace std;

class Player{
 public:
  Player();//string title_) {title = title_;};
  ~Player();
  void Debug() const;
  void ToTags();
  void AddTitle(string);
  void GetTitle() const;
 private:
  string title;
};

/*
class Player
  attr_accessor :who, :date, :id
    
  def debug
    puts "Player: #{@who}. ID: #{@id}. Date: #{@date}"
  end 

  def tagify
    @who = $tag_map[@who]   
  end
  
end
*/