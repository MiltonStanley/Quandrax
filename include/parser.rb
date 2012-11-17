#parser.rb

file = File.open("provMap.h",'r')

multis = 0
current_line = -1
while line = file.gets
	current_line += 1
	puts line if line.include? ' 0,'
	if line.include? ']'
	  line.sub!("//","")
		puts line.sub!("]","")
		multis += 1
	end
end

puts multis