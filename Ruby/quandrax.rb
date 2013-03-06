###############################################################################
# 
# Title:        Quandrax
# File:         Quandrax.rb
# Function:     Main program
# Description:  The QUick ANd Dirty paRAdoX converter, a project to create 
#               a single, unified save game converter.
# Author:       Milton Stanley
# Version:      2.0.0 - Ruby
# License:      Too complicated. You can use this all you want. To edit it,
#               you must do so through the Github page via pull requests, etc.
#               at http://www.github.com/MiltonStanley/Quandrax_1.1.0
###############################################################################

require './lib/prov_map.rb'   # Maps CK2 provs to EU3 provs - index is EU3 prov, data is CK2
require './lib/tag_map.rb'    # Maps CK2 titles to EU3 tags, CK2 is key, EU3 is data
require './lib/config.rb'     # Handles configuration file
require './lib/file_handling' # Generalized handling of files (loading, creating, writing)
require './globals'           # Used in testing/debugging
require './lib/cli_parsing'
require './lib/header'      # Header class
require './lib/dynasties'
require './lib/character'
require './lib/id'
require './lib/religious_authority'
require './lib/provinces'
require './lib/titles'
require './lib/diplomacy'
require './lib/combat'
require './lib/war'
require './lib/active_war'
require './lib/footer'

OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI

make_classes(OLD_FILE_EXTENSION)

#cli_parse

# Find the savegame file and set up the converted one
old_file, new_file = load_file('ck2')

puts

process_file old_file

write_file(new_file)

