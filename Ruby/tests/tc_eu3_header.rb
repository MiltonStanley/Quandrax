##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_HEADER
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_EU3_HEADER < Test::Unit::TestCase

  def test_creation
    assert $EU3_HEADER.instance_of?(EU3_Header), 'Failed to create EU3 header'
  end

  def test_date
    assert_equal '1066.9.15', $EU3_HEADER.date
  end

  def test_tag
    assert_equal 'NRM', $EU3_HEADER.tag
  end
  
end