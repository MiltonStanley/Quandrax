class Titles
  attr_accessor :e_hre
  
  def initialize
    @e_hre = false # Have we found the start of the e_hre section?
  end

  def add(line)
    @e_hre = true if is_e_hre?(line)  # We've started e_hre title info!
  end

  def is_e_hre?(line) # Is line the start of the e_hre titular info?
    line =~ /^e_hre=/ 
  end




end