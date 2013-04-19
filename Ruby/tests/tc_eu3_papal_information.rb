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

  def test_papal_relations
    # If I assign directly, it messes up the other tests...
    papal_relations = Hash.new
    $EU3_PAPAL_INFORMATION.papal_relations.each { |id, val| papal_relations[id] = val}
    holder_index = $CK2_TITLES.holder_index
    cardinals = Hash.new
    while cardinals.length < 15
      cardinal_id, relations = papal_relations.shift
      cardinals[cardinal_id] = relations unless cardinals[cardinal_id]
    end
    _temp = Hash.new
    cardinals.each do |cardinal_id, relations|
    holder_index.each do |title, holder_id|
      if cardinal_id == holder_id
        tag = $TM_CK2_EU3[title]
        _temp[tag] = relations unless _temp[tag]
        break
      end
    end
    end
    cardinals = _temp
    cardinals.each { |a,b| puts "#{a} - #{b}"}
    puts cardinals.length
  end

end