###############################################################################
# 
# Title:        Quandrax
# File:         Quandrax.rb
# Function:     Main program
# Description:  The QUick ANd Dirty paRAdoX converter, a project to create 
#               a single, unified save game converter.
# Author:       Milton Stanley
# Version:      2.0.0 - Ruby
# License:      Too complicated. You can use this all you want. To edit it,
#               you must do so through the Github page via pull requests, etc.
#               at http://www.github.com/MiltonStanley/Quandrax_1.1.0
###############################################################################

puts
require './lib/prov_map.rb'
require './lib/tag_map.rb'
require './lib/config.rb'
require './lib/parsing.rb'

OLD_FILE_EXTENSION = '.ck2' # Eventually this will be automated OR passed in at CLI

filename = Dir.new(Dir.getwd).each { |file| break file if file.include?(OLD_FILE_EXTENSION) }
if filename.class == Dir
	puts
	puts "No file found!"
	puts "See the help documentation for usage."
	Kernel.exit
end
file_name, file_extension = filename.split('.',2)
puts
puts "Loading #{filename}."
oldFile = File.open("./#{filename}",'r')
puts "Creating #{file_name}.eu3."
newFile = File.new("#{file_name}.eu3",'w')

nest_level = 0

while line = oldFile.gets
	nest_level += check_nesting(line)
	puts "header line!" if header_line(line)
	puts "#{nest_level}: #{line}"
end
