##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_IMPERIAL_INFO
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_EU3_Imperial_Info < Test::Unit::TestCase

  def test_creation
    assert $EU3_IMPERIAL_INFO.instance_of?(EU3_Imperial_Information),
      'Failed to create EU3_Imperial_Info object'
  end

end