class Tracker
  attr_accessor :line_number, :nest_level, :location

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @location = 'header'
    @header_done = false
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
    @header_done = true if header_done?(line)
    if change_location?
      @location = line.sub(/=$/,'') unless line == '}'
    end
  end

  def header_done?(line)
    @nest_level == 0 && line == 'dynasties='
  end

  def change_location?
    @header_done && @nest_level == 0
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