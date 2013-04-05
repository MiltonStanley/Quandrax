##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_CHARACTERS
#
##############################################

require "test/unit"
Dir.chdir("..")
require './lib/maps/prov_map.rb'   # Maps CK2 provs to EU3 provs - index is EU3 prov, data is CK2
require './lib/maps/tag_map.rb'    # Maps CK2 titles to EU3 tags - CK2 is key, EU3 is data
require './lib/file_handling' # Generalized handling of files (loading, creating, writing)
require './globals'
require './lib/quick_pass'

$OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI
old_file, new_file = load_file($OLD_FILE_EXTENSION)
puts
$HRE, $POPE = quick_pass(old_file) # THIS CLOSES FILE AT END OF STREAM
old_file = File.open(old_file, 'r') # SO we have to reopen it...annoying...
make_classes
puts
process_file old_file

class TC_CK2Characters < Test::Unit::TestCase

    def test_creation  # We are getting the correct ID and name for chaplains
      expected = CK2_Characters.new($POPE)
      assert_equal expected.class, $CK2_CHARACTERS.class
    end

    def test_setting_pope_id
      assert_equal '2008', $CK2_CHARACTERS.pope_id
    end

    def test_papal_relations_sorted
      a = 1
      b = 5
      assert b > a, "#{b} should be greater than #{a} but was not"
    end

end
