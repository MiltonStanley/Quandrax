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

  def test_gameplay_settings
    expected =  {'advisors' => '0',
                'leaders' => '0',
                'colonists' => '0',
                'merchants' => '0',
                'missionaries' => '0',
                'inflation' => '0', 
                'size of colonists' => '0', 
                'difficulty' => '2', 
                'ai aggressiveness' => '0',
                'spread of land provinces' => '1', 
                'spread of sea provinces' => '0', 
                'spies' => '0',
                'lucky nation' => '0'
                }
    assert_equal expected, $EU3_HEADER.gameplay_settings
  end

  def test_start_date
    assert_equal '1066.9.15', $EU3_HEADER.start_date
  end
  
end