file = File.open("provMap.h",'r')

def show(line_number, line)
	puts "#{line_number}: #{line}"
end

list = []
multis = 0
current_line = -6
while line = file.gets
	current_line += 1
	if line.include? ']'
	  list[current_line.to_i] = true unless current_line.to_i < 0
	  line.sub!("//","")
		line.sub!("]","")
		show(current_line, line)
		multis += 1
	end
end

list.each_index do |index|
	puts index if list[index] == true
end


puts multis