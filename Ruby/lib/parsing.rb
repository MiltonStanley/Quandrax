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