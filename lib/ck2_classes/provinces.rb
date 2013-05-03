##############################################################################
#
# Holds all the data making up the Province section in a CK2 Savegame,
# and passes the data to EU3 sections as appropriate.
#
# The specific data for individual provinces are passed to the A_CK2_Province class
#
##############################################################################

class CK2_Provinces
  ##
  # An Array. Index is the CK2 Province id; Data is an A_CK2_Province object
  attr_accessor :provinces

  def initialize
    puts "Reading CK2 provinces..."
    @provinces = Array.new
    @provinces << nil
  end

  def add(line)
    if is_province_header?(line)
      @provinces << A_CK2_Province.new(line.chop)
    else
      @provinces.last.add(line)  # Passes it on to A_CK2_Province's add
    end
  end

  def is_province_header?(line)
    line =~ /^\d+=$/
  end

end

###############################
#
# A_CK2_Province holds the province's
# specific data.
#
# It's passed to it by CK2_Provinces via the add method.
#
###############################

class A_CK2_Province
  
  # This is the ID of the province in CK2 (also the index in CK2_Provinces.provinces), String
  attr_accessor :ck2_id
  # The province's name in CK2 (String)
  attr_accessor :name
  # The province's culture in CK2 (String)
  attr_accessor :culture
  # The province's religion in CK2 (String)
  attr_accessor :religion
  # The province's max number of settlements in CK2 (String)
  attr_accessor :max_settlements
  # The province's title (as in nobility) in CK2 (String)
  attr_accessor :title
  # The province's tech levels in CK2 (Array)
  attr_accessor :tech_level
  # The province's progress towards next tech levels in CK2 (Array)
  attr_accessor :tech_progress

  def initialize(id)
    @ck2_id = id
    @tech_level = Array.new
  end

  def add(line)
    key, value = split_key_value(line)
    @name = value.gsub('"','') if is_name?(key)
    @culture = value if is_culture?(key)
    @religion = value if is_religion?(key)
    @max_settlements = value if is_max_settlements?(key)
    @title = value.gsub('"','') if is_title?(key)
    @tech_level = get_tech_level(line) if is_tech_level?(line)
    @tech_progress = get_tech_progress(line) if is_tech_progress?(line)
  end

  def write_brief
    print "id #{@ck2_id}, name \"#{@name}\", \
culture #{@culture}, religion #{@religion}, max_settlements = \
#{@max_settlements}, title #{@title}, tech_level "
    @tech_level.each { |lev| print "#{lev} " }
    print ", tech_progress "
    @tech_progress.each { |prog| print "#{prog} "}
    puts
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