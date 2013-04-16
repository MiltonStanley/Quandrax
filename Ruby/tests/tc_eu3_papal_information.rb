##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_PAPAL_INFORMATION
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_PapalInformation < Test::Unit::TestCase

  def test_creation
    assert $EU3_PAPAL_INFORMATION.instance_of?(EU3_Papal_Information),
          'Failed to create EU3 Papal information'
  end

  def test_cardinals_sorting
    expected = $CK2_CHARACTERS.papal_relations.sort { |a, b| b[1]<=>a[1] }
    assert_equal expected, $EU3_PAPAL_INFORMATION.cardinals
  end

end