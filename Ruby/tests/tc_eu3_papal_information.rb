##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_PAPAL_INFORMATION
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_PapalInformation < Test::Unit::TestCase

  def test_creation
    assert $EU3_PAPAL_INFORMATION.instance_of?(EU3_Papal_Information),
          'Failed to create EU3 Papal information'
  end

  def test_papal_relations_length
    assert_equal 7639, $EU3_PAPAL_INFORMATION.papal_relations.length
  end
  
  def test_cardinal_sort
    last_val = 100_000
    $EU3_PAPAL_INFORMATION.papal_relations.each do |key, val|
      assert last_val >= val, "#{last_val} expected >= #{val}, but isn't"
      last_val = val
    end
  end

  def test_papal_controller
    papal_controller = $EU3_PAPAL_INFORMATION.papal_controller
    assert_equal "NAV", papal_controller
  end

  def test_cardinal_controllers_length
    assert_equal 15, $EU3_PAPAL_INFORMATION.cardinal_controllers.length
  end

  def test_cardinal_controllers_titles
    expected_titles = %w[ k_navarra c_valladolid c_coimbra d_barcelona
                          c_empuries d_slavonia c_vannes c_csanad d_transylvania
                          c_galloway c_cumberland c_nice c_cagliari c_orvieto c_benevento
                        ]
    assert_equal expected_titles, $EU3_PAPAL_INFORMATION.cardinal_controllers
  end

  def test_cardinal_names
    expected_names = ['Gomez', 'Fernando', 'Hermenegildo', 'Ramon', 'Berenguer',
                      'Jitej', 'Andrev', "Luk\u00E1cs", "Gell\u00E9rt",
                      'Flaithbertach', 'Eadbeorht', 'Cangrande', 'Vitale', 
                      'Adriano', 'Amedeo'
                      ]
    assert_equal expected_names, $EU3_PAPAL_INFORMATION.cardinal_names
  end

  def test_cardinal_location_names
    expected_locations = %w[b_pamplona b_valladolid b_coimbra b_barcelona b_empuries 
                            b_zagreb b_vannes b_csanad b_csik b_dunragit 
                            b_burgh b_nizza b_cagliari b_orvieto b_ascoli
                            ]
    assert_equal expected_locations, $EU3_PAPAL_INFORMATION.cardinal_location_names
  end

  def test_cardinal_controller_tags
    expected_tags = %w[NAV CAS POR CAT ARA CRO BRI HUN TRA SCO NOL GEN SAR PAP NAP]
    assert_equal expected_tags, $EU3_PAPAL_INFORMATION.cardinal_controller_tags
  end


  def test_cardinal_province_ids
    expected_ids = ['152', '198', '159', '204', '205', '461', '105', 
                    '521', '540', '50', '53', '230', '326', '243', '335']
    assert_equal expected_ids, $EU3_PAPAL_INFORMATION.cardinal_province_ids
  end

end