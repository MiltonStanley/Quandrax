##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_DYNASTIES
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

class Test_CK2_Dynasties < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      expected = CK2_Dynasties.new
      assert_equal expected.class, $CK2_DYNASTIES.class
    end

end
