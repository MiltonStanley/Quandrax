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
    nations = Array.new
    file = File.open('./lib/templates/nations.tmp','r')
    file.each_line do |line|
      line = line.chomp
      if is_new_nation?(line)
        nations << AnEU3Nation.new(line.chop)
      else
        nations.last.add(line)
      end
    end
  end

  def is_new_nation?(line)
    line =~ /^\w{3}=$/
  end

end

class AnEU3Nation

  def initialize(tag)
    @tag = tag
  end

  def add(line)

  end

end
