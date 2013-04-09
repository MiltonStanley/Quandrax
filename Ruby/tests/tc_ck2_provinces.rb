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

end
