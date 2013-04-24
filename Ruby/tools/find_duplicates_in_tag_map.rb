file = File.open('../lib/maps/tag_map.rb','r')

titles = Array.new
line_number = 0
while line = file.gets
  line_number += 1
  line.gsub!('"','')
  title, b = line.split(' => ',2)
  puts "#{line_number}: #{title}" if titles.include?(title)
  titles << title
end