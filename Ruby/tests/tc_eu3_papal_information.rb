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

  def test_cardinals_title_to_tag_conversion
    $EU3_PAPAL_INFORMATION.cardinals.each do |key, var|
      assert $TM_CK2_EU3.has_key?(key), "Tag Map does not have #{key}"
    end
  end

end