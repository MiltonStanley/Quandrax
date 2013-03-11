file = File.open('../WilliamBeginning.eu3','r')

def nation_header?(line)
  !(line =~/^[\s\t]/) && !(line =~ /^\d/) && line.length == 4
end

new_nation = true
new_monarch = true

while line = file.gets
  line.chomp!
  if nation_header?(line)
    new_nation = true
    nation = line.splice!
  end
  if new_nation
    puts line if line =~ /^\s+(monarch=)/
  end  
	
end