require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

class TC_TagConversion < Test::Unit::TestCase

    def test_tag_conversion_httt
      run_config
      expected = "MUR" if ($VERSION == 2 || $VERSION == 3)
      expected = "MOS" if $VERSION == 1
      assert_equal expected, $TM_CK2_EU3["c_murom"]
    end

    def test_tag_conversion_dw
      run_config
      expected = "ULM" if $VERSION == 3
      expected = "BAD" if ($VERSION == 1 || $VERSION == 2)
      assert_equal expected, $TM_CK2_EU3["c_ulm"]
    end
end