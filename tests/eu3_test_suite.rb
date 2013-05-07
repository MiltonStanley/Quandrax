require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

require './tests/tc_eu3_header'
require './tests/tc_eu3_imperial_info'
require './tests/tc_eu3_defenders_of_the_faith'
require './tests/tc_eu3_papal_information'
require './tests/tc_eu3_provinces'
require './tests/tc_eu3_nations'
