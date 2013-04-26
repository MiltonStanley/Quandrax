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
=begin
  def get_province_report
    provinces = $CK2_PROVINCES.provinces
    liege_index = $CK2_TITLES.liege_index
    titles = $CK2_TITLES.titles
    to_tag = $TM_CK2_EU3
    [7,8,11].each do |ck2_province_id|
      title = provinces[ck2_province_id].title
      liege = liege_index[title]
      liege ||= titles[title].de_jure_liege
      liege_liege = liege_index[liege]
      tag = to_tag[title]
      liege_tag = to_tag[liege]
      liege_liege_tag = to_tag[liege_liege]
      puts "CK2 id: #{ck2_province_id} | controller #{title
            } (#{tag}) | lieges: #{liege} (#{liege_tag}) -> #{liege_liege} (#{liege_liege_tag})"
    end
  end
=end
end