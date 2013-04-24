require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/maps/tag_map'
end

class TestTagMap < Test::Unit::TestCase

  def test_no_nils
    $TM_CK2_EU3.each { |title, tag| assert !tag.nil?, "Tag expected for #{
                                                      title} but was nil." }
  end

end