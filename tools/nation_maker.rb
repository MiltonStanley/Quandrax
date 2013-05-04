file = File.open('./sweden.txt', 'r')

class EU3Nation

  def initialize(tag)
    @tag = tag
    @in_history = true
    @history = String.new
  end

  def add(line)
    @in_history = false if is_flags?(line) || is_date?(line)
    process_history(line) if @in_history
  end

  def write
    puts "#{@tag}=\n{\n\t#{@history}"
  end

  def process_history(line)
    @history << line
  end

  def is_history?(line)
    line =~ /^\t(history=)/
  end

  def is_date?(line)
    line =~ /^\t\t\d{4}.\d+.\d+=$/
  end

  def is_flags?(line)
    line =~ /^\t(flags=)/
  end

  def is_capital?(line)
    line =~ /^\t(capital)/
  end

end

def is_new_nation?(line)
  line =~ /^\w{3}=/
end

nations = Hash.new
current_nation = String.new

file.each_line do |line|
  if is_new_nation?(line)
    tag = line.chomp.chop
    current_nation = tag
    nations[current_nation] = EU3Nation.new(tag)
  else
    nations[current_nation].add(line)
  end
end

a_nation = nations['SWE']

a_nation.write