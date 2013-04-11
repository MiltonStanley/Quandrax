##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_TITLES
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

class TC_CK2_Titles < Test::Unit::TestCase

    def test_creation
      assert $CK2_TITLES.instance_of?(CK2_Titles), 
        "Failed to create CK2_Titles variable"
    end

    def test_hre_id
      assert_equal  '1316', $CK2_TITLES.hre_id
    end

    def test_hre_titles
      hre_titles = %w[e_hre c_nassau b_nassau d_franconia
                      c_leiningen b_leiningen c_wurzburg
                      b_schweinfurt c_bamberg b_babenberg
                      ]
      assert_equal hre_titles, $CK2_TITLES.hre_titles
    end

    def test_names_match_titles_key
      $CK2_TITLES.titles.each do |title, a_title|
        assert_equal title, a_title.name
      end
      assert $CK2_TITLES.titles['e_hre'].name == 'e_hre'
    end

    def test_holder_ids
      holder_ids = { 'c_boulogne' => '20142', 'k_england' => '122', 'd_osterreich' => '7200' }
      $CK2_TITLES.titles.each do |title, a_title|
        if holder_ids[title]
          assert_equal holder_ids[title], a_title.holder_id
        end
      end
    end

    def test_lieges
      lieges = {'d_osterreich' => 'e_hre', 'b_furth' => 'c_nurnberg', 
                'c_orbetello' => 'k_papal_state', 'b_alsalihiyah' => 'c_pelusia'
                }
      $CK2_TITLES.titles.each do |title, a_title|
        if lieges[title]
          assert_equal lieges[title], a_title.liege
        end
      end
    end

    def test_succession_laws
      succession_laws = {'k_england' => 'primogeniture', 'e_hre' => 'feudal_elective', 
                        'e_timurids' => 'turkish_succession', 'd_northumberland' => 'gavelkind'}
      $CK2_TITLES.titles.each do |title, a_title|
        if succession_laws[title]
          assert_equal succession_laws[title], a_title.succession_law
        end
      end
    end

    def test_gender_laws
      gender_laws = {'k_england' => 'agnatic', 'e_hre' => 'agnatic', 
                    'e_timurids' => 'agnatic', 'd_northumberland' => 'cognatic' }
      $CK2_TITLES.titles.each do |title, a_title|
        if gender_laws[title]
          assert_equal gender_laws[title], a_title.gender_law
        end
      end
    end

    def test_de_jure_lieges
      de_jure_lieges = {'d_northumberland' => 'k_england', 'k_england' => 'e_britannia',
                        'd_meath' => 'k_ireland' }
      $CK2_TITLES.titles.each do |title, a_title|
        if de_jure_lieges[title]
          assert_equal de_jure_lieges[title], a_title.de_jure_liege
        end
      end
    end

    def test_liege_index_creation
      assert $CK2_TITLES.liege_index.length > 0,
        'Expected liege_index size to be greater than 0'
    end

    def test_liege_index
      lieges = {'d_osterreich' => 'e_hre', 'b_furth' => 'c_nurnberg', 
                'c_orbetello' => 'k_papal_state', 'b_alsalihiyah' => 'c_pelusia'
                }
      $CK2_TITLES.liege_index.each do |vassal, liege|
        if lieges[vassal]
          assert_equal lieges[vassal], $CK2_TITLES.liege_index[vassal]
        end
      end
    end

    def test_holder_index_creation
      assert $CK2_TITLES.holder_index.length > 0,
        'Expected holder_index size to be greater than 0'
    end

    def test_holder_index
      holders = {'d_osterreich' => '7200', 'b_furth' => '500650', 
                'c_orbetello' => '2008', 'b_alsalihiyah' => '501589'
                }
      $CK2_TITLES.holder_index.each do |title, holder|
        if holders[title]
          assert_equal holders[title], $CK2_TITLES.holder_index[title]
        end
      end
    end

    def test_setting_history
      assert_equal true, $CK2_TITLES.titles['e_hre'].history
      assert_equal true, $CK2_TITLES.titles['k_england'].history
    end

    def test_triggering_holder
      hre_titles = ['e_hre', 'd_franconia']
      test = A_Title.new('e_hre')
      test.add("\thistory=\n", hre_titles)
      assert_equal true, test.history
    end

    def test_triggering_last_holder
      hre_titles = ['e_hre', 'd_franconia']
      lines = ["\thistory=", "\t{", "\t\t768.9.24=", "\t\t{", "\t\tholder=6392",
      "\t\t}", "\t\t814.1.28=", "\t\t{", "\t\tholder=90095", "\t\t}"]
      test = A_Title.new('e_hre')
      lines.each { |line| test.add(line, hre_titles) }
      assert test.last_holder
      #assert_equal '90095', test.last_holder
    end

end