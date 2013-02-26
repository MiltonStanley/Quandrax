class Tracker
  attr_accessor :line_number, :nest_level, :location

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @location = 'header'
  end

  def update_nesting(line)
    if line.include? '{'
      return 1 
    elsif line.include? '}'
      return -1 
    else
      return 0
    end
  end

  def update(line)
    @line_number += 1 
    @nest_level += update_nesting(line)
    if @nest_level == 0 && line == 'dynasties='
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