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

end