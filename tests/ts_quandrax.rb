require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

require './tests/tc_ck2_header'
require './tests/tc_ck2_dynasties'
require './tests/tc_ck2_characters'
require './tests/tc_ck2_id'
require './tests/tc_ck2_religious_authority'
require './tests/tc_ck2_provinces'
require './tests/tc_ck2_titles'
require './tests/tc_eu3_header'
require './tests/tc_eu3_imperial_info'
require './tests/tc_eu3_defenders_of_the_faith'
require './tests/tc_eu3_papal_information'
require './tests/tc_eu3_provinces'
require './tests/tc_eu3_nations'
require './tests/tc_parsing'
require './tests/tc_array_inversion'
require './tests/tc_tag_map'
require './tests/tc_province_map'
require './tests/tc_culture_map'
require './tests/tc_eu3_footer_a'
require './tests/tc_eu3_japanese'