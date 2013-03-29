class EU3_Provinces

  def initialize(provinces)
    @provinces = provinces
  end

  def write(location)
    @provinces.each { |prov| puts "#{prov.ck2_id} is named \"#{prov.name}\"" }
  end

end