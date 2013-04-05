require "test/unit"

Dir.chdir("..")
require './lib/maps/prov_map.rb'   # Maps CK2 provs to EU3 provs - index is EU3 prov, data is CK2
require './lib/maps/tag_map.rb'    # Maps CK2 titles to EU3 tags - CK2 is key, EU3 is data
require './lib/file_handling' # Generalized handling of files (loading, creating, writing)

$OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI

# Find the savegame file and set up the converted one
old_file, new_file = load_file($OLD_FILE_EXTENSION)
puts

make_classes

puts

process_file old_file

class TestCourtChaplains < Test::Unit::TestCase

    def test_id_name_jobs  # We are getting the correct ID and name for chaplains
    end

end