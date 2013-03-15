# Titles.rb
# 
# Holds Pertinent CK2 title info for future use

class Titles
   
  def initialize
    @in_e_hre_title_info = false # Have we found the start of the e_hre section?
  end

  def add(line)
    @in_e_hre_title_info = true if is_e_hre?(line)  # We've started e_hre title info!
    if is_hre_holder?(line) && @in_e_hre_title_info
      #trash, @e_hre = split_key_value(line)
      throwaway, @e_hre = split_key_value(line)
      @in_e_hre_title_info = false
    end
  end

  def write(location)
    location.puts "HRE holder is #{@e_hre}"
  end

  def is_e_hre?(line) # Is line the start of the e_hre titular info?
    line =~ /^e_hre=/ 
  end

  def is_hre_holder?(line)
    line.lstrip =~ /^holder=/
  end




end