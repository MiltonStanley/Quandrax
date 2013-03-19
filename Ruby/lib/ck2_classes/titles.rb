# Titles.rb
# 
# Holds Pertinent CK2 title info for future use

class CK2_Titles
  attr_accessor :hre_id, :hre_titles

  def initialize(hre)
    puts "Reading CK2 titles..."
    @hre_id = hre
    @title_info = Array.new
  end

  def add(line)
    if is_title_header?(line)
      @title_info << Title.new(line.chop)
    else
      @title_info.last.add(line)
    end


  end

  def write(location)
    puts "The HRE is #{@hre_id}"
  end

  def is_title_header?(line)
    line =~ /^[bcdke]_/
  end

end

class Title

  def initialize(name)
    @name = name
  end

  def add(line)
    line = line.rstrip.lstrip
    key, value = split_key_value(line)
    if is_liege?(key)
     
      @liege = get_liege(line) 
       puts "#{@liege} - #{@name}"
    end
  end

  def is_liege?(key)
    key == 'liege'
    
  end

  def get_liege(line)
     _, liege = split_key_value(line)
     liege.gsub("\"",'')
  end
end