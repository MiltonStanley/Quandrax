# Titles.rb
# 
# Holds Pertinent CK2 title info for future use
#
# MOST IMportant stuff is passed to the A_Title class Below


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
      @title_info.last.add(line)  # Passes it on to A_Title's add
    end
  end

  def write(location)
    title_info_write
    puts "The HRE is #{@hre_id}"
  end

  def title_info_write
    @title_info.each { |a_title| a_title.write }
  end

  def is_title_header?(line)
    line =~ /^[bcdke]_/
  end

end

###############################
#
# A Title does most of the
# real heavy lifting
#
###############################

class A_Title

  attr_accessor :name, :liege, :succession_law, :gender_law

  def initialize(name)
    @name = name
  end

  def add(line)
    key, value = split_key_value(line)
    @liege = value.gsub('"','') if is_liege?(key) # Strip "s for better string handling
    @succession_law = value if is_succession_law?(key)
    @gender_law = value if is_gender_law?(key)
  end

  def write
    print "#{@name}: liege=#{@liege}, succession law=#{@succession_law}"
    puts ", gender law=#{@gender_law}"
  end

  def is_liege?(key)
    key =~ /^\t(liege)/ # Triggers on [tab]liege, not histories w/ tabS
  end

  def is_succession_law?(key)
    key =~ /^\t(succession)/
  end

  def is_gender_law?(key)
    key =~ /^\t(gender)/
  end

end