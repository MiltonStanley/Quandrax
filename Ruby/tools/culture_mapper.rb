one_file = File.open('../../../cultures')
#new_file = File.new('./culture_map.rb','w')

puts "Manually remove last , in new file"

#new_file.puts 'CC_CK2_EU3 = {'
puts 'CC_CK2_EU3 = {'
while line = one_file.gets
  culture, _ = line.split("\t", 2)
  puts "  \"#{culture.downcase}\" => "
end

#new_file.puts '}'
puts '}'