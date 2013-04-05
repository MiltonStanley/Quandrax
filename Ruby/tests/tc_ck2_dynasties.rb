##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_DYNASTIES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_tests'
end

class TC_CK2Dynasties < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      assert $CK2_DYNASTIES.instance_of? CK2_Dynasties
    end

end