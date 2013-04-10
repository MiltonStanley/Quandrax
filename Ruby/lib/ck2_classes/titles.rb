# Titles.rb
# 
# Holds Pertinent CK2 title info for future use
#
# MOST Important stuff is passed to the A_Title class Below

class CK2_Titles
  attr_accessor :hre_id, :hre_titles, :titles, :liege_index

  def initialize(hre)
    puts "Reading CK2 titles..."
    @hre_id = hre
    @hre_titles = Array.new   # Holds all titles of the Emperor of the HRE
    @titles = Hash.new   # Array of all the titles
    @liege_index = Hash.new
    @last_title = nil
  end

  def add(line)
    if is_title_header?(line)
      @liege_index[@last_title] = @titles[@last_title].liege unless @last_title.nil?
      @last_title = line.chop
      @titles[@last_title] = A_Title.new(@last_title)
    else
      @titles[@last_title].add(line, @hre_titles)  # Passes it on to A_Title's add
    end
  end

  def is_title_header?(line)
    line =~ /^[bcdke]_/
  end

end

###############################
#
# A_Title does most of the
# real heavy lifting
#
###############################

class A_Title

  attr_accessor :name, :holder_id, :liege, :succession_law, :gender_law, :de_jure_liege

  def initialize(name)
    @name = name
    @laws = Array.new
    @holder_id = String.new
  end

  def add(line, hre_titles)
    key, value = split_key_value(line)
    @liege = value.gsub('"','') if is_liege?(key) # Strip "s for better string handling
    if is_holder?(key)
      @holder_id = value
      hre_titles << @name if value == $HRE
    end
    @succession_law = value if is_succession_law?(key)
    @gender_law = value if is_gender_law?(key)
    add_law(value) if is_law?(key)
    @de_jure_liege = value.gsub('"','') if is_de_jure_liege?(key)
  end

  def add_law(value)
    @laws << value
  end

  def is_liege?(key)
    key =~ /^\t(liege)/ # Triggers on [tab]liege, not histories w/ tabS
  end

  def is_holder?(key)
    key =~ /^\t(holder)/
  end

  def is_succession_law?(key)
    key =~ /^\t(succession)/
  end

  def is_gender_law?(key)
    key =~ /^\t(gender)/
  end

  def is_law?(key)
    key =~ /^\t(law)/
  end

  def is_de_jure_liege?(key)
    key =~ /^\t(de_jure_liege)/
  end

end