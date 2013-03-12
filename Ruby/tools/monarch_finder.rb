file = File.open('../WilliamBeginning.eu3','r')

def nation_header?(line)
  !(line =~/^[\s\t]/) && !(line =~ /^\d/) && line.length == 4
end

def monarch_line?(line)
  line =~ /^\s+(monarch=)/
end

def id_line?(line)
  line =~ /^\s+(id=)\d+/
end

new_nation = false
new_monarch = false

while line = file.gets
  line.chomp!
  if nation_header?(line)
    nation = line.gsub!('=','')
    new_nation = true
  end
  if monarch_line?(line) && new_nation
    new_monarch = true
  end
  if id_line?(line) && new_nation && new_monarch
    puts "#{nation}- monarch=#{line.lstrip.sub('id=','')}"
    new_nation = false
    new_monarch = false
  end
	
end