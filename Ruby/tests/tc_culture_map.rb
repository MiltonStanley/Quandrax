require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/maps/culture_map'
  require './tests/setup_for_eu3_tests'
end

class Test_Culture_Map < Test::Unit::TestCase

  def test_valid_keys
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil? || a_province.culture.nil?
      assert $CM_CK2_EU3.has_key?(a_province.culture),
        "Failed to find #{a_province.culture} key in culture map!"
    end
  end

  def test_valid_values
    actual_cultures = Array.new
    $EU3_PROVINCES.provinces.each do |a_province|
      next if a_province.nil? || a_province.culture.nil?
      actual_cultures << a_province.culture unless actual_cultures.include?(a_province.culture)
    end
    $CM_CK2_EU3.each_value do |culture|
      assert actual_cultures.include?(culture), "Game doesn't seem to use culture #{culture}!" unless culture == 'SPECIAL'
    end
  end

end