class EU3_Nations
  attr_accessor :nations

  def initialize(ck2_provinces)
    @nations = get_nations(ck2_provinces)
  end

  def get_nations(ck2_provinces)
    nations = Array.new
    ck2_provinces.each do |a_prov|
      tag = $TM_CK2_EU3[a_prov.title]
      nations << tag unless nations.include? tag
    end
    nations
  end

end