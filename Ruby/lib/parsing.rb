def check_nesting(line)
	if line.include? '{'
		return 1
	elsif line.include? '}'
		return -1
	else
		return 0
	end
end

def header_line(line)

end