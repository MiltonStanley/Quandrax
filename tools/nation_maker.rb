file = File.open('../lib/templates/nations.tmp', 'r')

class EU3Nation

  def initialize(tag)
    @tag = tag
  end

end

def is_new_nation?(line)
  line =~ /^\w{3}=/
end

nations = Hash.new

file.each_line do |line|
  tag = line.chop.chomp if is_new_nation?(line)
  nations[tag] = EU3Nation.new(tag)
end