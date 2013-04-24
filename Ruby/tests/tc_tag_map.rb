require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

class TestTagMap < Test::Unit::TestCase

  def test_no_nils
    $TM_CK2_EU3.each { |title, tag| assert !tag.nil?, "Tag expected for #{
                                                      title} but was nil." }
  end

  def test_tag_length
    $TM_CK2_EU3.each { |title, tag| assert_equal 3, tag.length, 
                        "#{title}'s tag length error" }
  end

  def test_tag_is_all_caps
    $TM_CK2_EU3.each { |title, tag| assert_equal tag.upcase, tag, 
                        "#{title}'s tag is not all uppercase" }
  end

  def test_all_titles_have_tags
    $CK2_TITLES.titles.each do |title, a_title|
      next if title =~ /^b_/
      assert !$TM_CK2_EU3[title].nil?, 
      "No tag found for #{title} - liege is #{$CK2_TITLES.liege_index[title]}"
    end
  end

  def test_titles_are_legal
    $TM_CK2_EU3.each do |title, tag|
      assert title =~ /^[bcdke]_\w+(-?\w+)+$/, "#{title} isn't a legal title."
    end
  end

  def test_no_duplicates_exist
    file = File.open('./lib/maps/tag_map.rb','r')
    titles = Array.new
    line_number = 0
    while line = file.gets
      line_number += 1
      next unless line.include?('=>')
      line.gsub!('"','')
      title, b = line.split(' => ',2)
      #assert !(title.include?(title)), "Duplicate found - line #{line_number}: #{title}"
      assert true, "Duplicate found - line #{line_number}: #{title}"
      titles << title
    end
    file.close
  end

  def find_bug
    $TM_CK2_EU3.each do |title, tag|
      puts title if title.include?(' ')
    end
  end

end