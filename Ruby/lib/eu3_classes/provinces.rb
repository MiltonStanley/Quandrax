class EU3_Provinces

  def initialize(provinces)
    @provinces = provinces
  end

  def write(location)
    @provinces.each do |prov| 
      print "id #{prov.ck2_id}, name \"#{prov.name}\", \
culture #{prov.culture}, religion #{prov.religion}, max_settlements = \
#{prov.max_settlements}, title #{prov.title}, tech_level "
      prov.tech_level.each { |lev| print "#{lev} " }
      puts
    end
  end

end