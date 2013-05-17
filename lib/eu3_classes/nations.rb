class EU3_Nations
  attr_accessor :tag_list, :nations, :date

  def initialize(ck2_provinces)
    puts 'Creating EU3 Nations section'
    @tag_list = get_tag_list(ck2_provinces)
    @nations = get_nations
  end

  def write(location, date)
    @nations.each { |tag, a_nation| a_nation.write(location, date) }
  end

  def get_tag_list(ck2_provinces)
    tag_list = Array.new
    ck2_provinces.each do |a_prov|
      next if a_prov.nil?
      tag = $TM_CK2_EU3[a_prov.title]
      tag_list << tag unless tag_list.include?(tag) || tag.nil?
    end
    tag_list
  end

  def get_nations
    nations = Hash.new
    current_nation = String.new
    file = File.open('./lib/templates/nations.tmp','r')
    file.each_line do |line|
      line = line.chomp
      if is_new_nation?(line)
        tag = line.chop
        current_nation = tag
        nations[tag] = AnEU3Nation.new(tag)
      else
        nations[current_nation].add(line)
      end
    end
    nations
  end

  def is_new_nation?(line)
    line =~ /^\w{3}=$/
  end

end

class AnEU3Nation
  attr_accessor :tag, :government, :sliders, :technology_group, :unit_type,
    :primary_culture, :religion, :accepted_cultures, :capital, :monarch_date,
    :monarch_name, :technology, :luck, :prestige

  def initialize(tag)
    @tag = tag
    @monarch_date = get_monarch_date
    @monarch_name = get_monarch_name
    @sliders = Hash.new
    @accepted_cultures = Array.new
    @technology = Hash.new
    @luck = false
  end

  def add(line)
    line = line.lstrip.rstrip
    key, value = split_key_value(line)
    @government = value if is_key?('government',key)
    @sliders[key] = value if is_slider?(key)
    @technology_group = value if is_key?('technology_group', key)
    @unit_type = value if is_key?('unit_type', key)
    @primary_culture = value if is_key?('primary_culture', key)
    @religion = value if is_key?('religion', key)
    @accepted_cultures << value if (is_key?('accepted_culture', key) || is_key?('add_accepted_culture', key)) unless @accepted_cultures.include?(value)
    @capital = value if is_key?('capital', key)
    @technology[key] = value.sub('}','').sub('{','') if is_technology?(key)
    @luck = true if is_key?('luck', key)
  end

  def write(location, date)
    location.puts "#{@tag}=\n{"
    write_history(location)
    location.puts "\tflags=\n\t{\n\t}\n\thidden_flags=\n\t{\n\t}\n\tvariables=\n\t{\n\t}"
    location.puts "\tcapital=#{@capital}\n\tnational_focus=#{@capital}\n\tlast_focus_move=\"1.1.1\""
    location.puts "\tprimary_culture=#{@primary_culture}" unless @primary_culture.nil?
    @accepted_cultures.each { |culture| location.puts "\taccepted_culture=#{culture}"}
    location.puts "\treligion=#{@religion}" unless @religion.nil?
    location.puts "\ttechnology_group=#{@technology_group}"
    location.puts "\tunit_type=#{@unit_type}"
    location.puts "\ttechnology=\n\t{"
    @technology.each { |tech, value| location.puts "\t\t#{tech}={#{value}}" }
    location.puts "\t}"
    location.puts "\tluck=yes" if @luck
    location.puts "\tlast_election=\"#{date}\"\n\tauto_send_merchants=yes"
    location.puts "}"
  end

  def write_history(location)
    location.puts "\thistory=\n\t{"
    location.puts "\t\tgovernment=#{@government}" unless @government.nil?
    @sliders.each { |slider, value| location.puts "\t\t#{slider}=#{value}" }
    location.puts "\t\ttechnology_group=#{@technology_group}\n\t\tunit_type=#{@unit_type}"
    location.puts "\t\tprimary_culture=#{@primary_culture}" unless @primary_culture.nil?
    location.puts "\t\treligion=#{@religion}" unless @religion.nil?
    @accepted_cultures.each { |culture| location.puts "\t\tadd_accepted_culture=#{culture}"}
    write_monarch_information(location)
    location.puts "\t}"
  end

  def write_monarch_information(location)
    return if monarch_date.nil? || monarch_name.nil?
    location.puts "\t\t#{@monarch_date}=\n\t\t{\n\t\t\tmonarch=\n\t\t\t{"
    location.puts "\t\t\t\tname=\"#{@monarch_name}\"\n\t\t\t\tDIP=5\n\t\t\t\tADM=5"
    location.puts "\t\t\t\tMIL=5\n\t\t\t\tid=\n\t\t\t\t{\n\t\t\t\t\tid=1533\n\t\t\t\t\ttype=37"
    location.puts "\t\t\t\t}\n\t\t\t}\n\t\t}"
  end

  def is_key?(expected, actual)
    expected == actual
  end

  def is_slider?(key)
    %w[aristocracy_plutocracy centralization_decentralization
      innovative_narrowminded mercantilism_freetrade offensive_defensive
      land_naval quality_quantity serfdom_freesubjects].include?(key)
  end

  def is_technology?(key)
    %w[land_tech naval_tech trade_tech production_tech government_tech].include?(key)
  end

  def get_monarch_date
    title = get_top_title(tag)
    date = $CK2_TITLES.titles[title].coronation_date unless $CK2_TITLES.titles[title].nil?
    date
  end

  def get_monarch_name
    title = get_top_title(tag)
    holder_id = $CK2_TITLES.titles[title].holder_id unless $CK2_TITLES.titles[title].nil?
    name = $CK2_CHARACTERS.characters[holder_id].birth_name unless $CK2_CHARACTERS.characters[holder_id].nil?
    name
  end


end
