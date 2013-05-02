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
                  206 => 'galician',
                  38 => 'latvian'
                }
    expected.each do |id, culture|
      assert_equal culture, $EU3_PROVINCES.provinces[id].culture, 
      "Expected #{culture} for province #{id}, got #{$EU3_PROVINCES.provinces[id].culture}!"
    end
  end

  def test_special_cultures_default
    expected = {1871 => 'rheinlaender',
                1872 => 'bavarian',
                1873 => 'austrian',
                1874 => 'hannoverian',
                1875 => 'umbrian',
                1876 => 'hessian',
                1877 => 'aquitaine',
                1878 => 'rheinlaender',
                1879 => 'aquitaine',
                1880 => 'rheinlaender'
                }
    expected.each do |id, expected|
      actual = $EU3_PROVINCES.provinces[id].culture
      assert_equal expected, actual, 
                        "Province #{id} should be #{expected} but was #{actual}"
    end
  end

  def test_scottish_conversion
    version1 = {'c_clydesdale' => 'lowland_scottish',
                'c_buchan' => 'highland_scottish',
                'c_null' => 'english'
                }
    version2 = {'c_clydesdale' => 'scottish',
                'c_buchan' => 'scottish',
                'c_null' => 'english'
                }
    if $VERSION == 1
      version1.each do |title, culture|
        assert_equal culture, get_scottish(title)
      end
    else
      version2.each do |title, culture|
        assert_equal culture, get_scottish(title)
      end
    end
  end


end