# Header.rb
# 
# Definitions for EU3 Header class
#
#

class Header
  
  def initialize
    puts "Making header section..."
    @gameplay_settings = Hash.new
    get_gameplay_settings    
  end

  def add(line)
    key, value = split_key_value(line)
    @date = value if is_date?(key)
    @tag = $TM_CK2_EU3[value.gsub("\"",'')] if is_realm?(key)
    do_gameplay_settings if is_gameplaysettings?(line)
  end

  def write
    puts "date=#{@date}"
    puts "player=#{@tag}"
    self.puts fake_MCLARU # Need to figure these out, then do them fo' realz
    puts "flags=\n{\n}"
    self.puts_gameplay_settings

    
=begin
    monarch=6840    // This seems to be hardcoded - can't find in the files
    cardinal=16     // 12 MAR 2013 - may be on the wrong track with these?
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

  def fake_MCLARU
    puts "monarch=6840\ncardinal=16\nleader=1184\nadvisor=1889\n"
    puts "rebel=41\nunit=1589"
  end

  def get_gameplay_settings
    need_valid_command = true
    while need_valid_command
      print "Do you want to manually set gameplay settings? Answer y, n, or ? for help: "
      command = gets.chomp.downcase
      command = command.gsub("'",'').gsub("\"",'')
      command = command[0]
      if command == 'n'
        puts "Using default settings..."
        self.use_default_settings
        need_valid_command = false
      end
      if command == 'y'
        self.use_manual_settings
        need_valid_command = false
      end
      show_settings_help if command == 'h' || command == '?'
    end
  end

  def show_settings_help
    puts
    puts "The gameplay settings are the options found in the"
    puts "'Options' button in the lower righthand screen when"
    puts "Starting a new game. It's used to customize various"
    puts "gameplay settings. If you don't know what it is, I'd"
    puts "recommend using the default settings (answer 'n' at the"
    puts "prompt)."
    puts
  end

  def use_manual_settings
    settings = {'advisors' => ['normal', 'historical', 'event'],
                'leaders' => ['normal', 'historical', 'event'],
                'colonists' => ['normal', 'free'],
                'merchants' => ['normal', 'free'],
                'missionaries' => ['normal', 'free'],
                'inflation' => ['normal', 'none', 'from gold'], 
                'size of colonists' => ['normal', '200', '300', '400'], 
                'difficulty' => ['very easy', 'easy', 'normal', 'hard', 'very hard'], 
                'ai aggressiveness' => ['normal', 'low', 'high'],
                'spread of land provinces' => ['25', 'normal 50', '75', '100', '200'], 
                'spread of sea provinces' => ['25', 'normal 50', '75', '100', '200'], 
                'spies' => ['normal', 'free'],
                'lucky nation' => ['historical', 'random', 'none']
                }

    settings.each do |key, value|
      @gameplay_settings[key] = set_gameplay_setting(key, value)
    end
    
  end

  def set_gameplay_setting(setting, options)
    need_valid_input = true
    while need_valid_input
      puts
      puts "#{setting.capitalize}"
      print "Options: "
      options.each_index { |index| print "#{index+1}) #{options[index]} "}
      puts; print "Choice: "
      choice = gets.chomp.to_i
      if choice > options.length || choice < 1
        puts "Choice must be between 1 and #{options.length}!"
      else
        need_valid_input = false
      end      
    end
    choice
  end

  def use_default_settings    
    @gameplay_settings = {'advisors' => '0',
                'leaders' => '0',
                'colonists' => '0',
                'merchants' => '0',
                'missionaries' => '0',
                'inflation' => '0', 
                'size of colonists' => '0', 
                'difficulty' => '2', 
                'ai aggressiveness' => '0',
                'spread of land provinces' => '1', 
                'spread of sea provinces' => '0', 
                'spies' => '0',
                'lucky nation' => '0'
                }
  end

  def puts_gameplay_settings
    puts "gameplaysettings=\n{\n\s\ssetgameplayoptions=\n\s\s{\n"
    @gameplay_settings.each { |key, value| print "#{value} "}
    puts "\s\s}\n}"
  end

=begin


    gameplaysettings=                 // SEE BELOW
    {                                 # Just realized I used C++ comments...
      setgameplayoptions=             #
      {                               #
    0 0 0 0 0 0 0 2 0 1 0 0 0   }     # SEE BELOW - EITHER prompt each, or default
    }
=end

  def is_date?(key)
    key == 'date'
  end

  def is_realm?(key)
    key == 'player_realm'
  end

  def is_gameplaysettings?(line)
    line == 'gameplaysettings='
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