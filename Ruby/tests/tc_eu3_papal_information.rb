##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_PAPAL_INFORMATION
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_PapalInformation < Test::Unit::TestCase

  def test_creation
    assert $EU3_PAPAL_INFORMATION.instance_of?(EU3_Papal_Information),
          'Failed to create EU3 Papal information'
  end

  def test_papal_relations_length
    assert_equal 7639, $EU3_PAPAL_INFORMATION.papal_relations.length
  end
  
  def test_cardinal_sort
    last_val = 100_000
    $EU3_PAPAL_INFORMATION.papal_relations.each do |key, val|
      assert last_val >= val, "#{last_val} expected >= #{val}, but isn't"
      last_val = val
    end
  end

  def test_papal_controller
    papal_controller = $EU3_PAPAL_INFORMATION.papal_controller
    assert_equal "NAV", papal_controller
  end

  def test_cardinal_controllers_length
    assert_equal 15, $EU3_PAPAL_INFORMATION.cardinal_controllers.length
  end

end