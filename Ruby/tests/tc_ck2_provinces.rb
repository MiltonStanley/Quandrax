##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_PROVINCES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_tests'
end

class TC_CK2Provinces < Test::Unit::TestCase

  def test_creation
    assert $CK2_PROVINCES.instance_of?(CK2_Provinces),
          "Failed to create CK2_Provincess variable"
  end

  def test_provincesid_matches_each_province_id
    $CK2_PROVINCES.provinces.each_index do |index|
      next if $CK2_PROVINCES.provinces[index].nil?
      assert_equal index, $CK2_PROVINCES.provinces[index].ck2_id.to_i
    end
  end

  def test_names
    names = { 1 => 'Vestisland' , 170 => 'Denia', 685 => 'Kurdistan'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if names[a_province.ck2_id]
        expected = names[a_province.ck2_id]
        actual = a_province.name
        assert_equal expected, actual
      end
    end
  end

  def test_cultures
    cultures = { 1 => 'norwegian' , 170 => 'andalusian_arabic', 685 => 'kurdish'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if cultures[a_province.ck2_id]
        expected = cultures[a_province.ck2_id]
        actual = a_province.culture
        assert_equal expected, actual
      end
    end
  end

  def test_religions
    religions = { 1 => 'catholic' , 170 => 'sunni', 685 => 'sunni'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if religions[a_province.ck2_id]
        expected = religions[a_province.ck2_id]
        actual = a_province.religion
        assert_equal expected, actual
      end
    end
  end

  def test_max_settlements
    max_settlements = { 1 => '2' , 170 => '4', 685 => '5'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if max_settlements[a_province.ck2_id]
        expected = max_settlements[a_province.ck2_id]
        actual = a_province.max_settlements
        assert_equal expected, actual
      end
    end
  end

  def test_titles
    titles = { 1 => 'c_vestisland' , 170 => 'c_denia', 685 => 'c_kurdistan'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if titles[a_province.ck2_id]
        expected = titles[a_province.ck2_id]
        actual = a_province.title
        assert_equal expected, actual
      end
    end
  end

  def test_tech_level
    tech_levels = { 1 => '0 1 1 0 0 1 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 0 1 0' , 
                  170 => '0 1 0 0 1 1 1 1 2 2 2 2 2 2 2 1 1 2 2 2 2 2 2 2', 
                  685 => '0 1 1 0 0 1 1 1 2 2 2 2 2 2 2 2 2 1 2 3 2 2 2 2'}
    $CK2_PROVINCES.provinces.each do |a_province|
      next if a_province.nil?
      if tech_levels[a_province.ck2_id]
        expected = tech_levels[a_province.ck2_id]
        actual = a_province.tech_level
        assert_equal expected, actual
      end
    end
  end


end
