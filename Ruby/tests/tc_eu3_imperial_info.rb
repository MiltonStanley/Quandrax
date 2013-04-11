##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_IMPERIAL_INFO
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TC_EU3_Imperial_Info < Test::Unit::TestCase

  def test_creation
    assert $EU3_IMPERIAL_INFO.instance_of?(EU3_Imperial_Information),
      'Failed to create EU3_Imperial_Info object'
  end

  def test_hre_id
    assert_equal '1316', $EU3_IMPERIAL_INFO.hre_id
  end

  def test_hre_titles
    expected = %w[e_hre c_nassau b_nassau d_franconia
                  c_leiningen b_leiningen c_wurzburg
                  b_schweinfurt c_bamberg b_babenberg
              ]
    assert_equal expected, $EU3_IMPERIAL_INFO.hre_titles
  end

  def test_hre_tag
    expected = 'WUR'
    assert_equal expected, $EU3_IMPERIAL_INFO.hre_tag
  end

end