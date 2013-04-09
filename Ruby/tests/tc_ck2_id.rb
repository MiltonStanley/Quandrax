##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_ID
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_tests'
end

class TC_CK2ID < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      assert $CK2_ID.instance_of? CK2_ID
    end

end
