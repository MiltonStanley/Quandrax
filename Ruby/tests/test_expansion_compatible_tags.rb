require "test/unit"
require "../lib/tag_map.rb"
require "../lib/config.rb"

class TestTagConversion < Test::Unit::TestCase
    def test_tag_conversion_httt
      expected = "MUR" if ($VERSION == 2 || $VERSION == 3)
      expected = "MOS" if $VERSION == 1
      assert_equal expected, TM_CK2_EU3["c_murom"]
    end

    def test_tag_conversion_dw
      expected = "ULM" if $VERSION == 3
      expected = "BAD" if ($VERSION == 1 || $VERSION == 2)
      assert_equal expected, TM_CK2_EU3["c_ulm"]
    end
end

File.delete('config_file.rb')