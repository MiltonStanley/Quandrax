require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/maps/prov_map'
  require './lib/parsing'
end

class TestProvinceMap < Test::Unit::TestCase

  def test_array_dimension
    $PM_CK2_EU3.each do |pair|
      next if pair.nil?
      if pair.class == Array
        pair.each { |id| assert_equal 1.class, id.class }
      else
        assert_equal 1.class, pair.class
      end
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

  def test_german_conversions
    puts get_german('c_oldenburg')
    puts is_hannoverian?('c_oldenburg')
    puts $EU3_PROVINCES.provinces[55].culture
    expected = {55 => 'bavarian',
                1874 => 'hannoverian'
                }
    expected.each do |id, culture|
      assert_equal culture , $EU3_PROVINCES.provinces[id].culture
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