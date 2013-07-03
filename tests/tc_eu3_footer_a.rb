##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_FOOTER_A
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestEU3FooterA < Test::Unit::TestCase
  
  def test_creation
    assert $EU3_FOOTER_A.instance_of?(EU3_Footer_A),
          'Failed to create EU3 Footer A'
  end

end