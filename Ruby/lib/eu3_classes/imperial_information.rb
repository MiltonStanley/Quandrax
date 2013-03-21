class EU3_Imperial_Information

  def initialize(ck2_titles)
    puts "Creating EU3 Imperial Information section"
    @hre_id = ck2_titles.hre_id
    @hre_titles = ck2_titles.hre_titles
  end

  def write(location)
    hre_tag = get_hre_id_tag(@hre_titles)
    location.puts "emperor=\"#{hre_tag}\""
    location.puts "imperial_influence=20.000\ninternal_hre_cb=yes"
    location.puts "old_emperor=\n{\nid=2338\ncountry=\"#{hre_tag}\""
    location.puts "date=#{get_date($EU3_HEADER.date)}\n}"    
  end

  def get_hre_id_tag(titles)
    titles.each { |title| return $TM_CK2_EU3[title] if title =~ /^k_/ }
    titles.each { |title| return $TM_CK2_EU3[title] if title =~ /^d_/ }
    titles.each { |title| return $TM_CK2_EU3[title] if title =~ /^c_/ }
    titles.each { |title| return $TM_CK2_EU3[title] if title =~ /^b_/ }
    "HUN" # When in doubt, be historical
  end

  def get_date(current_date)
    date = current_date.gsub('"','')
    date[0..3] = (date.to_i - 12).to_s
    date
  end

end