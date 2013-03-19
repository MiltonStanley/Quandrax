class EU3_Header

  def initialize(ck2_class)
    @date = ck2_class.date
    @tag = ck2_class.tag
    @gameplay_settings = ck2_class.gameplay_settings
    @start_date = ck2_class.start_date
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

  def puts_gameplay_settings(location)
    location.puts "gameplaysettings=\n{\n\s\ssetgameplayoptions=\n\s\s{\n"
    @gameplay_settings.each { |key, value| location.print "#{value} "}
    location.puts "\s\s}\n}"
  end

end