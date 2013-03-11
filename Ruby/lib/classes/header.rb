# Header.rb
# 
# Definitions for EU3 Header class
#
#

class Header
  
  def initialize
    puts "Making header section..."
  end

  def add(line)
    key, value = split_key_value(line)
    @date = value if is_date?(key)
    @tag = $TM_CK2_EU3[value.gsub("\"",'')] if is_realm?(key)
  end

  def write
    puts "date=#{@date}"
    puts "player=#{@tag}"
    
=begin
    monarch=6840    // This seems to be hardcoded - can't find in the files
    cardinal=16     // "
    leader=1184     // "
    advisor=1889    // "
    rebel=41        // Not sure what this is
    unit=1589       // Probably related
    flags=          // STAYS
    {               // THE
    }               // SAME
    gameplaysettings=                 // SEE BELOW
    {                                 # Just realized I used C++ comments...
      setgameplayoptions=             #
      {                               #
    0 0 0 0 0 0 0 2 0 1 0 0 0   }     # SEE BELOW - EITHER prompt each, or default
    }                                 //  
    start_date="1399.10.14"           // same as CK2 *unless it breaks*
    id=                               // Gotta figure this out
    {                                 #
      id=3001                         #
      type=4713                       #
    }                                 #
   these are zero-indexed:
    advisors          *normal - historical - event
    leaders           *normal - historical - event
    colonists         *normal - free
    merchants         *normal - free
    missionaries      *normal - free
    inflation         *normal - none - from gold
    size of colonists *normal - 200 - 300 - 400
    difficulty        very easy - easy - *normal - hard - very hard
    ai aggressiveness *normal - low - high
    spread of land provinces  25 - *normal 50 - 75 - 100 - 200 -
    spread of sea provinces   *25 - normal 50 - 75 - 100 - 200
    spies             *normal - free
    lucky nation      *historical - random - none
=end
  end

  def is_date?(key)
    key == 'date'
  end

  def is_realm?(key)
    key == 'player_realm'
  end

end

=begin 

# Starts like this 

version="CK2 v1.06b"
date="1066.9.15"
player=
{
  id=140
  type=45
}
player_realm="d_normandy"
rebel=1
unit=54
sub_unit=107
start_date="1066.9.15"
flags=
{
}

# GOAL IS THIS FORMAT

  date="1399.10.14"
  player="ENG"
  monarch=6840
  cardinal=16
  leader=1184
  advisor=1889
  rebel=41
  unit=1589
  flags=
  {
  }
  gameplaysettings=
  {
    setgameplayoptions=
    {
  0 0 0 0 0 0 0 2 0 1 0 0 0   }
  }
  start_date="1399.10.14"
  id=
  {
    id=3001
    type=4713
  }

=end