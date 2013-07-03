##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_JAPANESE
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestEU3Japanese < Test::Unit::TestCase
  
  def test_creation
    assert $EU3_JAPANESE.instance_of?(EU3_Japanese),
          'Failed to create EU3 Japanese Info'
  end

end