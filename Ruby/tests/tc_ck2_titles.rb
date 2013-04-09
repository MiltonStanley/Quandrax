##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_TITLES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_tests'
end

class TC_CK2_Titles < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      assert $CK2_TITLES.instance_of?(CK2_Titles), 
        "Failed to create CK2_Titles variable"
    end

end