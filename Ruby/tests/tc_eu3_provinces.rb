##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_PROVINCES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestEU3Provinces < Test::Unit::TestCase
  
  def test_creation
    assert $EU3_PROVINCES.instance_of?(EU3_Provinces),
          'Failed to create EU3 Province information'
  end

  def test_provinces_have_a_name
    $EU3_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      assert !a_province.name.nil?, 
            "Province #{a_province.name} (#{a_province.id}) has no owner!"
    end
  end

  def test_owner_converts_correctly
    expecteds = { '145' => 'ACH',
                  '317' => 'NAX',
                  '373' => 'TYR',
                  '172' => 'GUY'
                }
    expecteds.each do |eu3_id, expected_owner|
      actual_owner = $EU3_PROVINCES.provinces[eu3_id.to_i].owner
      assert_equal expected_owner, actual_owner
    end
  end

end