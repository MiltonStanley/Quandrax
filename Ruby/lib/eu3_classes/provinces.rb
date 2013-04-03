require './lib/parsing'

class EU3_Provinces

  def initialize(provinces, titles)
    @provinces = provinces
    @titles = titles
    @all_eu3_provinces = make_provinces
    @province_index = invert($PM_CK2_EU3)
    # convert_provinces ~ convert province ~ con. 1-1, n-1; - in write, write them
  end

  def write(location)
    @all_eu3_provinces.each do |eu3_province|
      next if eu3_province.nil? # index 0 is nil, there's no province 0 in either game
      eu3_id = eu3_province.id.to_i
      ck2_id = @province_index[eu3_id]  # An array if multiple CK2's form one EU3
      if !(@province_index[eu3_id].nil?) # Do this if province is NOT in EU3
        eu3_province.convert_from_ck2(@provinces, @titles, ck2_id) 
      end
     eu3_province.write(location)
    end
  end

  def make_provinces
    temp_file = File.open('./lib/templates/province.tmp')
    array = Array.new
    array.push nil
    while line = temp_file.gets
      key, value = split_key_value(line.chomp)
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
  attr_accessor :id, :name

  def initialize(id)
    @finished_header = false
    @id = id
    @core = Array.new
    @history = String.new
  end

  def add(line)
    key, value = split_key_value(line.chomp)
    @name = value.gsub!('"','') if is_name?(key)
    @owner = value.gsub!('"','') if is_owner?(key)
    @controller = value.gsub!('"','') if is_controller?(key)
    @core << value.gsub!('"','') if is_core?(key)
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
    @finished_header = true if is_history?(line)
    @history << line if @finished_header
  end

  def convert_from_ck2(ck2_provinces, ck2_titles, ck2_id)
    if ck2_id.class == Fixnum
      # ck2_owner = ck2_provinces[ck2_id].liege || ck2_provinces[ck2_id].title
      # CK2 owner is province.title => that title's liege (titles.liege)
      # Need to make a liege index like in v1
      puts "#{id} - EU3 owner #{@owner}"#, CK2 owner #{ck2_owner}"
      # owner
      # controller
      # core
      # culture
      # religion
    elsif ck2_id.class == Array
      #puts "Convert n-1"
    end
  end

  def write(location)
    location.puts "#{id}=\n{\n\tflags=\n\t{\n\t}\n\tvariables=\n\t{\n\t}\n\tname=\"#{@name}\""
    location.puts "\towner=\"#{@owner}\"\n\tcontroller=\"#{@controller}\""
    @core.each { |core| location.puts "\tcore=\"#{core}\""}
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
