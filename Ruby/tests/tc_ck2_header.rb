##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_HEADER
#
##############################################

require "test/unit"
Dir.chdir("..")
require './lib/maps/prov_map.rb'   # Maps CK2 provs to EU3 provs - index is EU3 prov, data is CK2
require './lib/maps/tag_map.rb'    # Maps CK2 titles to EU3 tags - CK2 is key, EU3 is data
require './lib/file_handling' # Generalized handling of files (loading, creating, writing)
require './globals'

$OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI
old_file, new_file = load_file($OLD_FILE_EXTENSION)
puts
make_classes
puts
process_file old_file

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