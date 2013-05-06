require './lib/parsing'

class EU3_Provinces

  # Holds provinces. Index = EU3 Id, Data = An_EU3_Province
  attr_accessor :provinces, :province_map

  def initialize(ck2_provinces, titles, player_tag)
    @player_tag = player_tag
    @provinces = load_provinces_from_template # Array[eu3_id] = A_Province
    @province_map = invert($PM_CK2_EU3) 
    update_from_ck2(ck2_provinces)
  end

  def write(location, ck2_provinces)
    @provinces.each do |eu3_province|
      next if eu3_province.nil? # index 0 is nil, there's no province 0 in either game
      eu3_province.add_discovery_tags(ck2_provinces)
      eu3_province.write(location)
    end
  end

  def update_from_ck2(ck2_provinces)
    @provinces.each_index do |eu3_id|
      eu3_province = @provinces[eu3_id]
      next if @provinces[eu3_id].nil?                 # First one is nil - no province 0
      ck2_id = @province_map[eu3_id]
      next if ck2_id.nil?                             # Is nil if province isn't in CK2S
      
      if ck2_id.class == Fixnum                      # It's a 1:1 conversion - straight-forward!
        next if ck2_provinces[ck2_id].nil?                # We don't make provinces for water
        eu3_province.convert(ck2_provinces[ck2_id], @player_tag)
      elsif ck2_id.class == Array                    # Multiple CK2 provs make up this EU3 prov
        ck2_id.each do |id|                               # So we rotate through them
          ck2_province = ck2_provinces[id]
          eu3_province.convert(ck2_province, @player_tag)
        end    # Rotating through array of ck2_id's
      end    # What to do if it's array or fixnum
    end    # Updating all the EU3 provinces
  end    # Of the method

  def load_provinces_from_template
    temp_file = File.open('./lib/templates/province.tmp')
    array = Array.new
    array.push nil
    while line = temp_file.gets
      key, _ = split_key_value(line.chomp)
      if is_province_header?(key)
        array << An_EU3_Province.new(key) 
      else
        array.last.add(line)
      end
    end
    array
  end

  def is_province_header?(key)
    key =~ /^\d+/
  end

end


#################################
#
# An_EU3_Province handles each individual
# province.
#
#################################

class An_EU3_Province
  attr_accessor :id, :name, :owner, :controller, :cores, :culture, :religion,
    :discovery_dates, :patrol, :discovery_religion_dates, :discovered_by

  def initialize(id)
    @controller, @culture, @religion, @capital, @owner, @citysize, @garrison, 
                  @base_tax, @temple, @barracks, @drydock, @workshop, 
                  @marketplace, @manpower, @trade_goods, @fort1 = nil
    @in_history = false
    @id = id
    @cores = Array.new
    @history = String.new
    @discovered_by = Array.new
  end

  def add(line)
    key, value = split_key_value(line.chomp)
    @name = value.gsub!('"','') if is_name?(key)
    @owner = value.gsub!('"','') if is_owner?(key)
    @controller = value.gsub!('"','') if is_controller?(key)
    @cores << value.gsub!('"','') if is_core?(key)
    @culture = value if is_culture?(key)
    @religion = value if is_religion?(key)
    @capital = value.gsub!('"','') if is_capital?(key)
    @citysize = value if is_citysize?(key)
    @garrison = value if is_garrison?(key)
    @base_tax = value if is_base_tax?(key)
    @manpower = value if is_manpower?(key)
    @trade_goods = value if is_trade_goods?(key)
    @temple = value if is_temple?(key)
    @barracks = value if is_barracks?(key)
    @drydock = value if is_drydock?(key)
    @workshop = value if is_workshop?(key)
    @marketplace = value if is_marketplace?(key)
    @fort1 = value if is_fort1?(key)
    @in_history = true if is_history?(line)
    if is_patrol?(line)
      @in_history = false
      @patrol = value
    end
    @history << line if @in_history
    @discovery_dates = get_string_literals(value) if is_discovery_dates?(key)
    @discovery_religion_dates = get_string_literals(value) if is_discovery_religion_dates?(key)
    @discovered_by = get_string_literals(value) if is_discovered_by?(key)
  end

  def write(location)
    location.puts "#{id}=\n{\n\tflags=\n\t{\n\t}\n\tvariables=\n\t{\n\t}\n\tname=\"#{@name}\""
    location.puts "\towner=\"#{@owner}\"" unless @owner.nil?
    location.puts "\tcontroller=\"#{@controller}\""
    @cores.each { |core| location.puts "\tcore=\"#{core}\""}
    location.puts "\tculture=#{@culture}\n\treligion=#{@religion}\n\tcapital=\"#{@capital}\""
    location.puts "\tcitysize=#{@citysize}\n\tgarrison=#{@garrison}\n\tbase_tax=#{@base_tax}"
    location.puts "\tmanpower=#{@manpower}"
    location.puts "\ttrade_goods=#{@trade_goods}" unless @trade_goods.nil?
    location.puts "\ttemple=#{@temple}" unless @temple.nil?
    location.puts "\tbarracks=#{@barracks}" unless @barracks.nil?
    location.puts "\tdrydock=#{@drydock}" unless @drydock.nil?
    location.puts "\tworkshop=#{@workshop}" unless @workshop.nil?
    location.puts "\tmarketplace=#{@marketplace}" unless @marketplace.nil?
    location.puts "\tfort1=#{@fort1}" unless @fort1.nil?
    location.puts @history
    location.puts "\tpatrol=#{@patrol}"
    write_discovery_dates(location)
  end

  def add_discovery_tags(ck2_provinces)
    ck2_provinces.each do |a_prov|
      next if a_prov.nil?
      tag = $TM_CK2_EU3[a_prov.title]
      @discovered_by << tag unless @discovered_by.include? tag
    end
  end

  def convert(ck2_province, player_tag)
    @owner = $TM_CK2_EU3[ck2_province.title] unless @owner == player_tag
    @controller = @owner ### TODO - update when wars are added
    @cores << @owner
    @culture = get_culture(ck2_province.culture, ck2_province.title)
    @religion = $RM_CK2_EU3[ck2_province.religion]
  end

  def get_culture(ck2_culture, title)
    culture = $CM_CK2_EU3[ck2_culture]
    if culture == 'SPECIAL'
      culture = convert_special_culture(ck2_culture, title)
    end
    culture
  end

  def write_discovery_dates(location)
    location.print 'discovery_dates={'
    @discovery_dates.each do |date|
      location.print "#{date} "
    end
    location.puts ' }'

  end

  def is_patrol?(line)
    line =~ /^\t(patrol)/
  end

  def is_discovered_by?(key)
    key =~ /^discovered_by/
  end

  def is_discovery_dates?(key)
    key =~ /^discovery_dates/
  end

  def is_discovery_religion_dates?(key)
    key =~ /^discovery_religion_dates/
  end

  def get_string_literals(value)
    value.sub!('{','').sub!('}','')
    value.split(' ')
  end

  def is_player_owned?(eu3_id)
    $TM_CK2_EU3[@provinces[eu3_id].owner] == @player_tag
  end

  def is_name?(key)
    key =~ /^\tname/
  end

  def is_owner?(key)
    key =~ /^\towner/
  end

  def is_controller?(key)
    key =~ /^\tcontroller/
  end

  def is_core?(key)
    key =~ /^\tcore/
  end

  def is_culture?(key)
    key =~ /^\tculture/
  end

  def is_religion?(key)
    key =~ /^\treligion/
  end

  def is_capital?(key)
    key =~ /^\tcapital/
  end

  def is_citysize?(key)
    key =~ /^\tcitysize/
  end

  def is_garrison?(key)
    key =~ /^\tgarrison/
  end

  def is_base_tax?(key)
    key =~ /^\tbase_tax/
  end

  def is_manpower?(key)
    key =~ /^\tmanpower/
  end

  def is_trade_goods?(key)
    key =~ /^\ttrade_goods/
  end

  def is_temple?(key)
    key =~ /^\ttemple/
  end

  def is_barracks?(key)
    key =~ /^\tbarracks/
  end

  def is_drydock?(key)
    key =~ /^\tdrydock/
  end

  def is_workshop?(key)
    key =~ /^\tworkshop/
  end

  def is_marketplace?(key)
    key =~ /^\tmarketplace/
  end

  def is_fort1?(key)
    key =~ /^\tfort1/
  end

  def is_history?(line)
    line =~ /^\thistory=/
  end

end