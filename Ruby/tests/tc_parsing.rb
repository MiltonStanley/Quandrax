require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/parsing'
  require './lib/maps/tag_map'
end

class TestParsing < Test::Unit::TestCase

    def test_array_1d_conversion  # No overlappings
      original_array = [nil, 2, 3, 4, 5, 6]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, 2, 3, 4, 5]
      assert_equal(expected_array, inverted_array)
    end

    def test_array_2d_to_1d_conversion  # Base array MAY contain arrays; inverted doesn't
      original_array = [nil, 2, 3, 4, [5,6,7], 8]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, 2, 3, 4, 4, 4, 5]
      assert_equal(expected_array, inverted_array)
    end

    def test_array_1d_to_2d_conversion # Base 1d, but inverted can be 2d
      original_array = [nil, 2, 4, 6, 8,8, 10]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, nil, 2, nil, 3, nil, [4,5], nil, 6]
      assert_equal(expected_array, inverted_array)
    end

    def test_hash_sorting
      start_hash = {
                    "one" => 2, "two" => 1, "three" => 7,
                    "four" => 3, "five" => 3, "six" => 3,
                    "seven" => 0, "eight" => 10, "nine" => -7
                    }
      expected_hash = {
                    "eight" => 10, "three" => 7, "four" => 3, 
                    "five" => 3, "six" => 3, "one" => 2,
                    "two" => 1, "seven" => 0,  "nine" => -7
                    }
      start_hash = sort(start_hash)
      assert_equal expected_hash, start_hash
    end

    def test_title_to_tag_conversion
      start = ['k_england', 'd_lancaster', 'c_bourges', 'e_hre']
      expected = %w[ENG LAN BER HRE]
      start.each_index do |index|
        start[index] = convert_title_to_tag(start[index])
        assert_equal expected[index], start[index]
      end
    end

end