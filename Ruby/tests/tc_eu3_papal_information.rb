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

  def test_cardinals_length
    assert_equal 7639, $EU3_PAPAL_INFORMATION.cardinals.length
  end
  
  def test_cardinal_sort
    last_val = 100_000
    $EU3_PAPAL_INFORMATION.cardinals.each do |key, val|
      assert last_val >= val, "#{last_val} expected >= #{val}, but isn't"
      last_val = val
    end
  end

  def test_papal_controller
    papal_controller = $EU3_PAPAL_INFORMATION.papal_controller
    assert_equal "NAV", papal_controller
  end

  def test_cardinals
    # If I assign directly, it messes up the other tests...
    cardinals = Hash.new
    $EU3_PAPAL_INFORMATION.cardinals.each { |id, val| cardinals[id] = val}
    holder_index = $CK2_TITLES.holder_index
    shifted_cardinals = Hash.new
    while shifted_cardinals.length < 15
      cardinal_id, relations = cardinals.shift
      shifted_cardinals[cardinal_id] = relations unless shifted_cardinals[cardinal_id]
    end
    _temp = Hash.new
    shifted_cardinals.each do |cardinal_id, relations|
    holder_index.each do |title, holder_id|
      if cardinal_id == holder_id
        _temp[title] = relations unless _temp[title]
        next
      end
    end
    end
    shifted_cardinals = _temp
    shifted_cardinals.each { |a,b| puts "#{a} - #{b}"}
    puts shifted_cardinals.length
  end

end