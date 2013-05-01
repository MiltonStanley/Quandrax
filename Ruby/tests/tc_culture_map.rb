require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class Test_Culture_Map < Test::Unit::TestCase

  def test_has_all_ck2_cultures
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil? || a_province.culture.nil?
      assert $CM_CK2_EU3.has_key?(a_province.culture),
        "Failed to find #{a_province.culture} key in culture map!"
    end
  end

  def test_basic_mappings
    expected = {  89 => 'normand',
                  145 => 'greek',
                  464 => 'SPECIAL',
                  206 => 'galician',
                  373 => 'irish',
                  172 => 'breton'
                }
    expected.each do |id, culture|
      assert_equal culture, $EU3_PROVINCES.provinces[id].culture, 
      "Expected #{culture} for province #{id}, got #{$EU3_PROVINCES.provinces[id].culture}!"
    end
  end

  def test_special_cultures_default_values
    expected = { 317 => 'turkish'}
    expected.each do |id, culture|
      assert_equal culture, $EU3_PROVINCES.provinces[id].culture
    end
  end

end