class Tracker
  attr_accessor :line_number, :nest_level, :header_done

  def initialize(line_number, nest_level)
    @line_number = line_number
    @nest_level = nest_level
    @header_done = false
  end

  def header_done?
    @header_done
  end

end

def track_location_in_file(line, line_number, nest_level)
  line_number += 1
  nest_level += check_nesting(line)
end

def check_nesting(line)
	if line.include? '{'
		return 1
	elsif line.include? '}'
		return -1
	else
		return 0
	end
end

def class_header?(line, line_number, nest_level)
	nest_level == 0 && (line_number < 25 || nest_level == 0) # Problem in my approach
                                                           # Normally nest_level all that matters,
                                                           # But I've grouped singletons top levels
                                                           # Into a pseudo-class "header"
end

def character_header?(line, nest_level)
  nest_level == 0 && (line =~ /^b_/  ||
                      line =~ /^c_/ || 
                      line =~ /^d_/ || 
                      line =~ /^k_/ || 
                      line =~ /^e_/  )
end

def make_header(line)
  if $HEADER == true
    return line
  else
    # actually make it
    # return header
  end
end