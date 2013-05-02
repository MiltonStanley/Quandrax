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

  def test_owner_converts
    expecteds = { 145 => 'ACH',
                  317 => 'AYD',
                  373 => 'LEI',
                  172 => 'GUY'
                }
    expecteds.each do |eu3_id, expected_owner|
      actual_owner = $EU3_PROVINCES.provinces[eu3_id].owner
      assert_equal expected_owner, actual_owner
    end
  end

  def test_controller_converts
    expecteds = { 145 => 'ACH',
                  317 => 'AYD',
                  373 => 'LEI',
                  172 => 'GUY'
                }
    expecteds.each do |eu3_id, expected_controller|
      actual_controller = $EU3_PROVINCES.provinces[eu3_id].controller
      assert_equal expected_controller, actual_controller
    end
  end

  def test_cores
    expecteds = { 145 => 'ACH',
                  317 => 'AYD',
                  373 => 'LEI',
                  172 => 'GUY'
                }
    expecteds.each do |eu3_id, expected_core|
      assert $EU3_PROVINCES.provinces[eu3_id].cores.include?(expected_core),
        "Province #{eu3_id} should include core #{expected_core} but doesn't!"
    end
  end

  def test_basic_mappings
    expected = {  89 => 'normand',
                  145 => 'greek',
                  206 => 'galician',
                  38 => 'latvian'
                }
    expected.each do |id, culture|
      assert_equal culture, $EU3_PROVINCES.provinces[id].culture, 
      "Expected #{culture} for province #{id}, got #{$EU3_PROVINCES.provinces[id].culture}!"
    end
  end

  def test_special_cultures_default
    expected = {1871 => 'bavarian',
                1872 => 'bavarian',
                1873 => 'bavarian',
                1874 => 'bavarian',
                1875 => 'umbrian',
                1876 => 'bavarian',
                1877 => 'aquitaine',
                1878 => 'bavarian',
                1879 => 'aquitaine',
                1880 => 'bavarian'
                }
    expected.each do |id, culture|
      assert_equal culture, $EU3_PROVINCES.provinces[id].culture
    end
  end

  def test_scottish_conversion
    if $VERSION == 1
      assert_equal 'highlandscottish', get_scottish('test')
    else
      assert_equal 'scottish', get_scottish('test')
    end
  end

end