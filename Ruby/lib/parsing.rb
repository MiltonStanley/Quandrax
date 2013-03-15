
class Tracker
  attr_accessor :line_number, :nest_level, :location

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @location = 'header'
  end

  def update_nesting(line)
    if line.include? '{'
      @nest_level += 1
    elsif line.include? '}'
      @nest_level -= 1
    end
  end

  def update(line)
    @line_number += 1
    return 'break' if @line_number > $PARSE_TO unless $PARSE_TO == 0
    update_nesting(line)
    @location = change_location?(line)
    eval("parse_#{@location}(line)")
  end

  def change_location?(line)
    if specific_class_trigger?(line)
      return line.sub(/=$/,'')
    elsif generic_class_trigger?(line)
      return get_generic_class(line)
    else
      return @location
    end
  end

  def specific_class_trigger?(line)
    @nest_level == 0 && ( line == 'dynasties=' || line == 'character=' || 
                          line == 'id=' || line == 'diplomacy=' || line == 'combat=' ||
                          line == 'war=' || line == 'active_war=')
  end

  def generic_class_trigger?(line)
    @nest_level == 0 && (line == 'catholic=' || line == '1=' || 
                         line == 'e_rebels=' || footer_trigger?(line) )
  end

  def get_generic_class(line)
    if line == 'catholic='
      return 'religious_authority'
    elsif line == '1='
      return 'provinces'
    elsif line == 'e_rebels='
      return 'titles'
    elsif footer_trigger?(line)
       return 'footer'
    end
  end

  def footer_trigger?(line)
    @location == 'active_war' && line != 'active_war=' && !close_bracket?(line)
  end

  def close_bracket?(line)
    line == '}'
  end

end

def parse_header(line)
  $EU3_HEADER.add(line)
end

def parse_dynasties(line)
  # Do nothing for now...
end

def parse_character(line)

end

def parse_id(line)
  
end

def parse_religious_authority(line)
  
end

def parse_provinces(line)
  
end

def parse_titles(line)
  $TITLES.add(line)
end

def parse_diplomacy(line)
  
end

def parse_combat(line)

end

def parse_war(line) #not_love

end

def parse_active_war(line)

end

def parse_footer(line)

end

def split_key_value(line)
  key, value = line.split('=',2)
end