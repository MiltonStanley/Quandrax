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

  end

  def write(location)
    puts "The HRE is #{@hre_id}"
  end

end