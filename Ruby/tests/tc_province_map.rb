require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/maps/prov_map'
  require './lib/parsing'
end

class TestProvinceMap < Test::Unit::TestCase

  def test_array_dimension
    $PM_CK2_EU3.each do |pair|
      next if pair.nil?
      if pair.class == Array
        pair.each { |id| assert_equal 1.class, id.class }
      else
        assert_equal 1.class, pair.class
      end
    end
  end

end