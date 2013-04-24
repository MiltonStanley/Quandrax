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

end