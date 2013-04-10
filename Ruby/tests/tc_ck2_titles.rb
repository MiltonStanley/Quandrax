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
  require './tests/setup_for_tests'
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
          assert_equal a_title.holder_id, holder_ids[title]
        end
      end
    end

    def test_lieges
      lieges = {'d_osterreich' => 'e_hre', 'b_furth' => 'c_nurnberg', 
                'c_orbetello' => 'k_papal_state', 'b_alsalihiyah' => 'c_pelusia'
                }
      $CK2_TITLES.titles.each do |title, a_title|
        if lieges[title]
          assert_equal a_title.liege, lieges[title]
        end
      end
    end

    def test_succession_laws
      laws = {'k_england' => 'primogeniture', 'e_hre' => 'feudal_elective', 'e_timurids' => 'turkish_succession'}
      $CK2_TITLES.titles.each do |title, a_title|
        if laws[title]
          assert_equal laws[title], a_title.succession_law
        end
      end
    end

end