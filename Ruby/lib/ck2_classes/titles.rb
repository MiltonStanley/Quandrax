# Titles.rb
# 
# Holds Pertinent CK2 title info for future use
#
# MOST Important stuff is passed to the A_Title class Below

class CK2_Titles

  # ID of the Holy Roman Emperor (String)
  attr_accessor :hre_id
  # Titles held by the HRE (Array)
  attr_accessor :hre_titles
  # Information on individual titles. Title (string) => A_Title (string). (Hash)
  attr_accessor :titles
  # Holds liege of each title. Title (string) => Liege (string). (Hash)
  attr_accessor :liege_index
  # Holds ID of each title. Title (string) => Holder_ID (string). (Hash)
  attr_accessor :holder_index
  # Hold the last titles we've done for each rank - necessary for some de_jure_lieges
  # Hash - Key /[bcdk]_/ (String) => Liege /[cdke]_\w+/
  attr_accessor :current_hierarchy

  def initialize(hre)
    puts "Reading CK2 titles..."
    @hre_id = hre
    @hre_titles = Array.new   # Holds all titles of the Emperor of the HRE
    @titles = Hash.new   # Array of all the titles
    @liege_index = Hash.new
    @holder_index = Hash.new
    @current_title = nil
    @current_hierarchy = { :c => nil, :d => nil, :k_ => nil, :e => nil }
  end

  def add(line)
    if is_title_header?(line)
    unless @current_title.nil?
      @liege_index[@current_title] = @titles[@current_title].liege
      @holder_index[@current_title] = @titles[@current_title].holder_id
    end
      @current_title = line.chop
      rank, _ = line.split('_', 2)
      @current_hierarchy[rank] = @current_title
      @titles[@current_title] = A_Title.new(@current_title)
    else
      @titles[@current_title].add(line, @hre_titles)  # Passes it on to A_Title's add
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

  # Name of title (String)
  attr_accessor :name
  # ID of the title holder (String)
  attr_accessor :holder_id
  # Title's liege (String)
  attr_accessor :liege
  # Succession law for title (String)
  attr_accessor :succession_law
  # Gender law for title (String)
  attr_accessor :gender_law
  # Title's de jure liege (String)
  attr_accessor :de_jure_liege
  # Boolean - toggles true when we get to history section of title
  attr_accessor :history
  # Boolean - changes to ID of last holder (String)
  attr_accessor :last_holder
  # When current holder came to power (String)
  attr_accessor :coronation_date

  def initialize(name)
    @name = name
    @laws = Array.new
    @holder_id = String.new
    @history = false # Toggles true when we get to history section
    @last_holder = false
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
    @history = true if is_history_header?(line)
    if is_historic_holder?(line) && @history
      @last_holder = value.gsub('"','') unless value.gsub('"','') == @holder_id
    end
    @coronation_date = key.lstrip if is_coronation_date?(key) && @history
  end

  def is_coronation_date?(key)
    key =~ /^\t+\d+.\d+.\d+/
  end

  def is_historic_holder?(key)
    key =~ /^\t+(holder)/
  end

  def is_history_header?(line)
    line =~ /^\thistory=/
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