##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $EU3_NATIONS
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestEU3Nations < Test::Unit::TestCase
  
  def test_creation
    assert $EU3_NATIONS.instance_of?(EU3_Nations),
          'Failed to create EU3 Province information'
  end

  def test_nations_length
    assert_equal 337, $EU3_NATIONS.nations.length
  end

  def test_nations_have_valid_tag
    $EU3_NATIONS.nations.each do |tag, a_nation|
      assert_match /^[A-Z]{3}$/, a_nation.tag
    end
  end

  def test_nation_government
    expecteds = {'SWE' => 'feudal_monarchy',
                'GOT' => 'noble_republic',
                'SCA' => 'administrative_monarchy'
                }
    expecteds.each do |tag, government|
      assert_equal government, $EU3_NATIONS.nations[tag].government
    end
  end

  def test_sliders
    sliders = %w[aristocracy_plutocracy centralization_decentralization
                innovative_narrowminded mercantilism_freetrade offensive_defensive
                land_naval quality_quantity serfdom_freesubjects]                
    swe = Hash.new
    got = Hash.new
    sca = Hash.new
    sweden  = %w[-1 3 0 -3 0 -1 -2 2]
    sweden.each_index { |index| swe[sliders[index]] = sweden[index] }
    gotland = %w[1 2 1 -4 0 1 1 1]
    gotland.each_index { |index| got[sliders[index]] = gotland[index] }
    scandinavia = %w[0 3 -1 -3 0 0 -2 3]
    scandinavia.each_index { |index| sca[sliders[index]] = scandinavia[index] }
    expecteds = Hash.new
    expecteds['SWE'] = swe    
    expecteds['GOT'] = got
    expecteds['SCA'] = sca
    expecteds.each do |tag, sliders|
      assert_equal sliders, $EU3_NATIONS.nations[tag].sliders, "Incorrect sliders for #{tag}:"
    end
  end

  def test_technology_group
    expecteds = {'SWE' => 'western', 'ATH' => 'eastern', 'TUR' => 'ottoman'}
    expecteds.each do |tag, technology| 
      assert_equal technology, $EU3_NATIONS.nations[tag].technology_group
    end
  end

  def test_unit_type
    expecteds = {'SWE' => 'western', 'ATH' => 'eastern', 'TUR' => 'ottoman'}
    expecteds.each do |tag, type| 
      assert_equal type, $EU3_NATIONS.nations[tag].unit_type
    end
  end

  def test_primary_culture
    expecteds = {'SWE' => 'swedish', 'CRO' => 'croatian', 'FOI' => 'gascon'}
    expecteds.each do |tag, culture| 
      assert_equal culture, $EU3_NATIONS.nations[tag].primary_culture
    end
  end

  def test_religion
    expecteds = {'SWE' => 'catholic', 'EPI' => 'orthodox', 'GUJ' => 'sunni'}
    expecteds.each do |tag, religion|
      assert_equal religion, $EU3_NATIONS.nations[tag].religion
    end
  end

  def test_accepted_cultures
    expecteds = {'KRK' => %w[tamil], 'TUR' => %w[greek bulgarian],
                  'REB' => []}
    expecteds.each do |tag, cultures|
      assert_equal cultures, $EU3_NATIONS.nations[tag].accepted_cultures
    end
  end

  def test_capital
    expecteds = {'SWE' => '1', 'GEL' => '99', 'MUR' => '1754'}
    expecteds.each do |tag, capital|
      assert_equal capital, $EU3_NATIONS.nations[tag].capital
    end
  end

end