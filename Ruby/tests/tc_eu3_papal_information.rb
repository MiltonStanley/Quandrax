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
    assert_equal $EU3_PAPAL_INFORMATION.cardinals, $CK2_CHARACTERS.papal_relations
  end

end