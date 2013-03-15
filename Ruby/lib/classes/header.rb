# Header.rb
# 
# Definitions for EU3 Header class built from CK2 savefile

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
    @start_date = value if is_start_date?(key)
    
  end

  def write(location)
    location.puts "date=#{@date}"
    location.puts "player=#{@tag}"
    self.puts_MCLARU(location) # Need to figure these out, then do them fo' realz
    location.puts "flags=\n{\n}"
    self.puts_gameplay_settings(location)
    location.puts "start_date=#{@start_date}"
    self.puts_id(location)
  end

  def puts_MCLARU(location)
    location.puts "monarch=6840\ncardinal=16\nleader=1184\nadvisor=1889\n"
    location.puts "rebel=41\nunit=1589"
  end

  def puts_id(location)
    location.puts "id=\n{\n\s\sid=3001\n\s\stype=4713\n}"
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

  def puts_gameplay_settings(location)
    location.puts "gameplaysettings=\n{\n\s\ssetgameplayoptions=\n\s\s{\n"
    @gameplay_settings.each { |key, value| location.print "#{value} "}
    location.puts "\s\s}\n}"
  end

  def is_date?(key)
    key == 'date'
  end

  def is_realm?(key)
    key == 'player_realm'
  end

  def is_gameplaysettings?(line)
    line == 'gameplaysettings='
  end

  def is_start_date?(key)
    key == 'start_date'
  end 

end
