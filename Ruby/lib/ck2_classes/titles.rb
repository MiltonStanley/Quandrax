# Titles.rb
# 
# Holds Pertinent CK2 title info for future use

class CK2_Titles
  attr_accessor :hre_id, :hre_titles

  def initialize(hre)
    puts "Reading CK2 titles..."
    @hre_id = hre
  end

  def add(line)
    puts line if is_title_header?(line) # Should output JUST titles
  end

  def write(location)
    puts "The HRE is #{@hre_id}"
  end

  def is_title_header?(line)
    line =~ /^[bcdke]_/
  end

end

class Title

  def initialize

  end

end