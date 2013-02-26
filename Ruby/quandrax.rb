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

puts
require './lib/prov_map.rb'
require './lib/tag_map.rb'
require './lib/config.rb'
require './lib/parsing.rb'
require './lib/file_handling'
require './globals'

OLD_FILE_EXTENSION = 'ck2' # Eventually this will be automated OR passed in at CLI

# Find the savegame file and set up the converted one
old_file, new_file = load_file('ck2')

puts

process_file old_file
