require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './lib/maps/culture_map'
end

class Test_Culture_Map < Test::Unit::TestCase

  def test_basic_mappings
    expecteds = { 'norman' => 'normand', 'occitan' => 'occitain' }
    expecteds.each do |ck2, eu3|
      assert_equal eu3, $CM_CK2_EU3[ck2]
    end
  end

end