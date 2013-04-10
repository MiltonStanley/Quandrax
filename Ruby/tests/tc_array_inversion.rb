require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_ck2_tests'
end

class TC_ArrayConversion < Test::Unit::TestCase

    def test_1d_conversion  # No overlappings
      original_array = [nil, 2, 3, 4, 5, 6]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, 2, 3, 4, 5]
      assert_equal(expected_array, inverted_array)
    end

    def test_2d_to_1d_conversion  # Base array MAY contain arrays; inverted doesn't
      original_array = [nil, 2, 3, 4, [5,6,7], 8]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, 2, 3, 4, 4, 4, 5]
      assert_equal(expected_array, inverted_array)
    end

    def test_1d_to_2d_conversion # Base 1d, but inverted can be 2d
      original_array = [nil, 2, 4, 6, 8,8, 10]
      inverted_array = invert(original_array)
      expected_array = [nil, nil, 1, nil, 2, nil, 3, nil, [4,5], nil, 6]
      assert_equal(expected_array, inverted_array)
    end

end