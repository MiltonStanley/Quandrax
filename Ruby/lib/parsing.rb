class Tracker
  attr_accessor :line_number, :nest_level, :location

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @location = 'header'
    @generic_class = true
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
    update_nesting(line)
    @generic_class = make_generic_class?(line)
    if change_location? && !close_bracket?(line) # I don't like this - not clear enough
      @location = line.sub(/=$/,'')
    end
  end

  def make_generic_class?(line)
    triggers = ['dynasties=',]
    !(@nest_level == 0 && line == 'dynasties=')
  end

  def change_location?  # Here's the culprit - need to simplify this and above/below functions
    @generic_class && @nest_level == 0
  end

  def close_bracket?(line)
    line == '}'
  end

end


def character_header?(line, tracker)
  tracker.nest_level == 0 && (line =~ /^b_/  ||
                              line =~ /^c_/  || 
                              line =~ /^d_/  || 
                              line =~ /^k_/  || 
                              line =~ /^e_/   )
end

def make_header(line)
 line
end

def make_dynasties(line)
end