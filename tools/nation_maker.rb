Dir.chdir("..")

file = File.open('./lib/templates/nations.tmp', 'r')

file.each_line do |line|
  puts line if line =~ /^\w{3}=/
end
