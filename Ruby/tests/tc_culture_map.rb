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

  def test_german_conversions
    expected_cultures = {'c_valais' => 'rheinlaender',
                'c_ulm' => 'bavarian',
                'c_chur' => 'austrian',
                'c_oldenburg' => 'hannoverian',
                'c_nassau' => 'hessian',
                'c_trier' => 'rheinlaender',
                'c_sundgau' => 'rheinlaender'
                }
    expected_cultures.each do |title, expected|
      actual = convert_special_culture('german', title)
      assert_equal expected, actual, 
                    "Province #{title} should be #{expected} but was #{actual}"
    end
  end

  def test_scottish_conversion
    version1 = {'c_clydesdale' => 'lowland_scottish',
                'c_buchan' => 'highland_scottish',
                'c_null' => 'highland_scottish'
                }
    version2 = {'c_clydesdale' => 'scottish',
                'c_buchan' => 'scottish',
                'c_null' => 'scottish'
                }
    if $VERSION == 1
      version1.each do |title, culture|
        assert_equal culture, convert_special_culture('scottish', title)
      end
    else
      version2.each do |title, culture|
        assert_equal culture, convert_special_culture('scottish', title)
      end
    end
  end

  def test_dutch_conversions
    expected_cultures = {'c_anjou' => 'flemish',
                         'c_null' => 'dutch'
                        }
    expected_cultures.each do |title, expected|
      assert_equal expected, convert_special_culture('dutch',title)
    end
  end

  def test_frankish_conversions
    expected_cultures = { 'c_auxerre' => 'burgundian',
                          'c_zeeland' => 'wallonian',
                          'c_null' => 'aquitaine'
                        }
    expected_cultures.each do |title, expected|
      assert_equal expected, convert_special_culture('frankish', title)
    end
  end

  def test_italian_conversions
    expected_cultures = { 'c_venezia' => 'lombard',
                          'c_napoli' => 'sicilian',
                          'c_null' => 'umbrian'
                        }
    expected_cultures.each do |title, expected|
      assert_equal expected, convert_special_culture('italian', title)
    end
  end

  def test_castillan_conversions
    expected_cultures = { 'c_coruna' => 'galician',
                          'c_null' => 'castillian'
                        }
    expected_cultures.each do |title, expected|
      assert_equal expected, convert_special_culture('castillan', title)
    end
  end

  def test_finnish_conversions
    expected_cultures = { 'c_novgorod' => 'ingrian',
                          'c_narva' => 'estonian',
                          'c_null' => 'finnish'
                        }
    expected_cultures['c_kola'] = 'finnish' if $VERSION == '1'
    expected_cultures['c_kola'] ||= 'karelian'
    expected_cultures.each do |title, expected|
      assert_equal expected, convert_special_culture('finnish', title)
    end
  end

  def test_turkish_conversions
    expected_cultures = { 'c_tigris' => 'azerbadjani',
                          'c_bukhara' => 'turkmeni',
                          'c_null' => 'turkish'
                        }
    expected_cultures.each do |title, culture|
      assert_equal culture, convert_special_culture('turkish', title)
    end
  end

  def test_mongol_conversions
    expected_cultures = { 'c_tigris' => 'azerbadjani',
                          'c_bukhara' => 'turkmeni',
                          'c_null' => 'tartar'
                        }
    expected_cultures.each do |title, culture|
      assert_equal culture, convert_special_culture('mongol', title)
    end
  end

  def test_russian_conversions
    expected_cultures = { 'c_pinsk' => 'byelorussian',
                          'c_korsun' => 'ruthenian',
                          'c_null' => 'russian'
                        }
    expected_cultures.each do |title, culture|
      assert_equal culture, convert_special_culture('russian', title)
    end
  end

end