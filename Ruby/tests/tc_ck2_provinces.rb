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

    def test_provincesid_matches_each_province_id
      $CK2_PROVINCES.provinces.each_index do |index|
        next if $CK2_PROVINCES.provinces[index].nil?
        assert_equal index, $CK2_PROVINCES.provinces[index].ck2_id.to_i
      end
    end

end
