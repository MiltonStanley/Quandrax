# provinces.rb
# 
# Holds Pertinent CK2 province info for future use
#
# MOST Important stuff is passed to the A_Province class Below

class CK2_Provinces
  attr_accessor :provinces
  
  def initialize
    puts "Reading CK2 provinces..."
    @provinces = Array.new
  end

  def add(line)
    if is_province_header?(line)
      @provinces << A_Province.new(line.chop)
    else
      @provinces.last.add(line)  # Passes it on to A_province's add
    end
  end

  def is_province_header?(line)
    line =~ /^\d+=$/
  end

end

###############################
#
# A_Province does most of the
# real heavy lifting
#
###############################

class A_Province
  attr_accessor :ck2_id, :name, :culture, :religion,
                :max_settlements, :title, :tech_level, :tech_progress

  def initialize(id)
    @ck2_id = id
  end

  def add(line)
    key, value = split_key_value(line)
    @name = value.gsub('"','') if is_name?(key)
    @culture = value if is_culture?(key)
    @religion = value if is_religion?(key)
    @max_settlements = value if is_max_settlements?(key)
    @title = value if is_title?(key)
    @tech_level = get_tech_level(line) if is_tech_level?(line)
    @tech_progress = get_tech_progress(line) if is_tech_progress?(line)
  end

  def is_name?(key)
    key =~ /^\tname/
  end

  def is_culture?(key)
    key =~ /^\tculture/
  end

  def is_religion?(key)
    key =~ /^\treligion/
  end

  def is_max_settlements?(key)
    key =~ /^\tmax_settlements/
  end

  def is_title?(key)
    key =~ /^\ttitle/
  end

  def get_tech_level(line)
    line.gsub!('}','').split(' ')
  end

  def is_tech_level?(line)
    line =~ /^(\d )+\s+}/ && @tech_level.nil?
  end

  def get_tech_progress(line)
    line.gsub!('}','').split(' ')
  end

  def is_tech_progress?(line)
    line =~ /^(\d )+\s+}/ && @tech_level.length > 1
  end

end