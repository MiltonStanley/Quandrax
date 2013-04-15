##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_DEFENDERS_OF_THE_FAITH
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_DefendersOfTheFaith < Test::Unit::TestCase

  def test_creation
    assert $EU3_DEFENDERS_OF_THE_FAITH.instance_of?(EU3_Defenders_of_the_Faith),
          'Failed to create Defenders of the Faith Section'
  end

end