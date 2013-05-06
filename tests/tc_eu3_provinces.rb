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

  def test_cultures
    expected_cultures = { 145 => 'greek',
                          1874 => 'hannoverian',
                          370 => 'norwegian',
                          127 => 'lombard'
                        }
    expected_cultures.each do |id, expected|
      actual = $EU3_PROVINCES.provinces[id].culture
      assert_equal expected, actual
    end
  end

  def test_religions
    expected_religions = {126 => 'sunni', 
                          124 => 'sunni', 
                          39 => 'shamanism', 
                          41 => 'shamanism', 
                          40 => 'shamanism', 
                          42 => 'shamanism', 
                          43 => 'shamanism', 
                          271 => 'shamanism', 
                          225 => 'sunni', 
                          224 => 'sunni', 
                          218 => 'sunni', 
                          18 => 'shamanism', 
                          315 => 'shamanism'
                        }
    expected_religions.each do |id, religion|
      assert_equal religion, $EU3_PROVINCES.provinces[id].religion
    end
  end

  def test_patrol_value
    expecteds = {1    => '0',
                1262 => '35',
                1402 => '10'
                }
    expecteds.each do |id, expected|
      assert_equal expected, $EU3_PROVINCES.provinces[id].patrol
    end
  end

  def test_discovery_dates
    expecteds = {
        5  => %w[9999.1.1 9999.1.1 1.1.1 1.1.1 1.1.1 1.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1],
        82 => %w[9999.1.1 9999.1.1 1.1.1 1.1.1 1.1.1 1.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1],
      1423 => %w[9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1]
    }
    expecteds.each do |id, dates|
      assert_equal dates, $EU3_PROVINCES.provinces[id].discovery_dates
    end
  end

  def test_discovery_religion_dates
    expecteds = {
      239  => %w[9999.1.1 1399.10.14 9999.1.1 9999.1.1 1399.10.14 1399.10.14 1399.10.14 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1],
      1402 => %w[9999.1.1 1527.1.1 9999.1.1 9999.1.1 9999.1.1 1399.10.14 9999.1.1 1399.10.14 1399.10.14 1399.10.14 1399.10.14 1399.10.14 9999.1.1],
      1853 => %w[9999.1.1 1399.10.14 9999.1.1 9999.1.1 1399.10.14 1399.10.14 1399.10.14 1399.10.14 9999.1.1 9999.1.1 9999.1.1 9999.1.1 9999.1.1]
    }
    expecteds.each do |id, dates|
      assert_equal dates, $EU3_PROVINCES.provinces[id].discovery_religion_dates
    end
  end

end