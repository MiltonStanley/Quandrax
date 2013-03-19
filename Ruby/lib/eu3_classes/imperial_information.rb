class EU3_Imperial_Information

  def initialize(ck2_titles)

  end

  def write(location)
    title_info_write
    puts "The HRE is #{@hre_id}"
    print "HRE holds these titles: "
    @hre_titles.each { |title| print "#{title}, "}
    puts
  end

  def title_info_write
    @title_info.each { |a_title| a_title.write }
  end

end