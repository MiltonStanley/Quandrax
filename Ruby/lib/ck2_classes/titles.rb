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
      @title_info << A_Title.new(line.chop)
    else
      @title_info.last.add(line)
    end


  end

  def write(location)
    title_info_write
    puts "The HRE is #{@hre_id}"
  end

  def title_info_write
    @title_info.each { |a_title| puts "#{a_title.liege} is liege of #{a_title.name}" unless a_title.liege.nil? }
  end

  def is_title_header?(line)
    line =~ /^[bcdke]_/
  end

end

class A_Title

  attr_accessor :name, :liege

  def initialize(name)
    @name = name
  end

  def add(line)
    key, value = split_key_value(line)
    if is_liege?(key)
      @liege = value.gsub('"','') # Strip "s for better string handling
      # puts "#{@liege} - #{@name}"
    end
  end

  def is_liege?(key)
    key =~ /^\t(liege)/ # Triggers on [tab]liege, not histories w/ tabS
  end

end