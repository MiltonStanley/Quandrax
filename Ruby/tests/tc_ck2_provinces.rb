##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_PROVINCES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_tests'
end

class TC_CK2Provinces < Test::Unit::TestCase

    def test_creation
      assert $CK2_PROVINCES.instance_of?(CK2_Provinces),
            "Failed to create CK2_Provincess variable"
    end

end
