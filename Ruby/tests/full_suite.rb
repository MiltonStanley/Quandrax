require "test/unit"

if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

require './tests/ck2_test_suite'
require './tests/eu3_test_suite'
require './tests/tc_parsing'
require './tests/tc_array_inversion'
require './tests/tc_tag_map'