##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_HEADER
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

class TC_CK2Header < Test::Unit::TestCase

    def test_date  # We are getting the correct ID and name for chaplains
      assert_equal '1066.9.15', $CK2_HEADER.date
    end

    def test_tag
      assert_equal 'NRM', $CK2_HEADER.tag
    end

    def test_default_gameplay_settings
      default_gameplay_settings = {'advisors' => '0', 'leaders' => '0',
        'colonists' => '0', 'merchants' => '0', 'missionaries' => '0',
        'inflation' => '0', 'size of colonists' => '0', 'difficulty' => '2', 
        'ai aggressiveness' => '0', 'spread of land provinces' => '1', 
        'spread of sea provinces' => '0', 'spies' => '0','lucky nation' => '0'
        }
      assert_equal default_gameplay_settings, $CK2_HEADER.gameplay_settings
    end

    def test_start_date
      assert_equal "1066.9.15", $CK2_HEADER.start_date
    end

end