##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_NATIONS
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestEU3Nations < Test::Unit::TestCase
  
  def test_creation
    assert $EU3_NATIONS.instance_of?(EU3_Nations),
          'Failed to create EU3 Province information'
  end

  def test_nations_length
    assert_equal 337, $EU3_NATIONS.nations.length
  end

  def test_nations_have_valid_tag
    $EU3_NATIONS.nations.each do |tag, a_nation|
      assert_match /^[A-Z]{3}$/, a_nation.tag
    end
  end

end