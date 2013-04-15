class EU3_Imperial_Information
  attr_accessor :hre_id, :hre_titles, :hre_tag, :old_emperor_id, 
                :old_emperor_dynasty, :old_emperor_holdings, :old_emperor_tag,
                :same_dynasty, :old_emperor_date

  def initialize(ck2_titles, ck2_characters)
    puts "Creating EU3 Imperial Information section"
    @hre_id = ck2_titles.hre_id
    @hre_titles = ck2_titles.hre_titles
    @hre_tag = get_hre_id_tag(@hre_titles)
    @old_emperor_id = ck2_titles.titles['e_hre'].last_holder
    @old_emperor_dynasty = ck2_characters.characters[@old_emperor_id].dynasty
    @old_emperor_holdings = ck2_characters.characters[@old_emperor_id].old_holdings
    @old_emperor_tag = @hre_tag if @same_dynasty
    @old_emperor_tag ||= get_hre_id_tag(@old_emperor_holdings)
    @same_dynasty = true if ck2_characters.characters[@old_emperor_id].dynasty ==
                            ck2_characters.characters[@hre_id].dynasty
    @old_emperor_date  = ck2_titles.titles['e_hre'].coronation_date
  end

  def write(location)
    location.puts "emperor=\"#{@hre_tag}\""
    location.puts "imperial_influence=20.000\ninternal_hre_cb=yes"
    location.puts "old_emperor=\n{\nid=2338\ncountry=\"#{@old_emperor_tag}\""
    location.puts "date=#{@old_emperor_date}\n}"    
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