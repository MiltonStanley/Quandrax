require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

require './tests/tc_ck2_header'
require './tests/tc_ck2_dynasties'
require './tests/tc_ck2_characters'
require './tests/tc_ck2_id'
require './tests/tc_ck2_religious_authority'
require './tests/tc_ck2_provinces'
require './tests/tc_ck2_titles'