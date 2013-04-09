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

class TC_CK2ReligiousAuthority < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      assert $CK2_RELIGIOUS_AUTHORITY.instance_of?(CK2_Religious_Authority), 
              "Failed to create Religious Authority Object"
    end

end
