class EU3_Nations
  attr_accessor :tag_list, :nation_files

  def initialize(ck2_provinces)
    @tag_list = get_tag_list(ck2_provinces)
    @nation_files = get_nations
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
    file_list = Dir.entries('./lib/templates/countries')
    file_list.shift(2)
    nation_files = Hash.new
    file_list.each { |file| nation_files[file[0..2].upcase] = file }
    nation_files
  end


end