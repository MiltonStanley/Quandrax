# Models setup stuff for tests
# So they don't all have to call it

require './lib/maps/prov_map.rb'   # Maps CK2 provs to EU3 provs - index is EU3 prov, data is CK2
require './lib/maps/tag_map.rb'    # Maps CK2 titles to EU3 tags - CK2 is key, EU3 is data
require './lib/maps/culture_map'
require './globals'           # Used in testing/debugging
require './lib/config.rb'     # Handles configuration file for different EU3 versions
require './lib/file_handling' # Generalized handling of files (loading, creating, writing)
require './lib/quick_pass'    # Quick pass through file to pull out some info

$OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI
run_config
old_file, new_file = load_file($OLD_FILE_EXTENSION)
$HRE, $POPE = quick_pass(old_file) # THIS CLOSES FILE AT END OF STREAM
old_file = File.open(old_file, 'r') # SO we have to reopen it...annoying...
make_classes
process_file old_file