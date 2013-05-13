class EU3_Nations
  attr_accessor :tag_list, :nations

  def initialize(ck2_provinces)
    puts 'Creating EU3 Nations section'
    @tag_list = get_tag_list(ck2_provinces)
    @nations = get_nations
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
    :primary_culture, :religion, :accepted_cultures, :capital, :monarch_date

  def initialize(tag)
    @tag = tag
    @monarch_date = get_monarch_date
    @sliders = Hash.new
    @accepted_cultures = Array.new
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
    @accepted_cultures << value if is_key?('accepted_culture', key) || is_key?('add_accepted_culture', key)
    @capital = value if is_key?('capital', key)
  end

  def is_key?(expected, actual)
    expected == actual
  end

  def is_slider?(key)
    %w[aristocracy_plutocracy centralization_decentralization
      innovative_narrowminded mercantilism_freetrade offensive_defensive
      land_naval quality_quantity serfdom_freesubjects].include?(key)
  end

  def get_monarch_date
        
  end

  def get_coronation_date(title)
    $CK2_TITLES.titles[title].coronation_date
  end

  def is_invalid?(title)
    $CK2_TITLES.titles[title].nil? || title.nil?
  end

end
