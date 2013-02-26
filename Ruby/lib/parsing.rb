class Tracker
  attr_accessor :line_number, :nest_level, :location

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @location = 'header'
    @change_location = false
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
    @change_location = true if line == 'dynasties='
    if @nest_level == 0 && @change_location == true
      @change_location = true
      @location = line.sub(/=$/,'')
    end
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
  if $HEADER == true
    return line
  else
    # actually make it
    # return header
  end
end

def make_dynasties(line)
end