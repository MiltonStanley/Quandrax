##############################################
#
# This assumes WilliamBeginning.ck2 testfile
#
# This Global Object: $CK2_CHARACTERS
#
##############################################

require "test/unit"
if __FILE__ == $0
  Dir.chdir("..")
  require './tests/setup_for_eu3_tests'
end

class TestCK2Characters < Test::Unit::TestCase

  def test_creation  # We are getting the correct ID and name for chaplains
    assert $CK2_CHARACTERS.instance_of?(CK2_Characters), "Failed to create CK2_Characters variable"
  end

  def test_setting_pope_id
    assert_equal '2008', $CK2_CHARACTERS.pope_id
  end

  def test_papal_relations_length
    assert $CK2_CHARACTERS.papal_relations.length > 0, "Failed to add characters to papal relations list"
  end

  def test_birth_name
    names = { '70556' => 'Ioannes', '140' => 'William', '502636' => 'Jean' }
    names.each do |id, expected|
        actual = $CK2_CHARACTERS.characters[id].birth_name
        assert_equal expected, actual
    end
  end

  def test_host
    hosts = { '500354' => '106000', '140' => '214', '502636' => '93502' }
    hosts.each do |id, expected|
      actual = $CK2_CHARACTERS.characters[id].host
      assert_equal expected, actual
    end
  end

  def test_job_title
    job_titles = { '70556' => nil, '140' => 'job_marshal', '502636' => "job_chancellor" }
    job_titles.each do |id, expected|
      actual = $CK2_CHARACTERS.characters[id].job_title
      assert_equal expected, actual
    end
  end

  def test_alive
    alive = { '70556' => false, '140' => true, '502636' => true }
    alive.each do |character_id, expected|
      actual = $CK2_CHARACTERS.characters[character_id].alive
      assert_equal expected,  actual
    end
  end

  def test_friends_of_pope
    allies = { '106000' => 400, '140' => 347, '522' => 192 }
    allies.each do |id, expected|
      actual = $CK2_CHARACTERS.characters[id].papal_relation_value
      assert_equal expected, actual
    end
  end

  def test_papal_relations_hash
    relations = { '106000' => 400, '140' => 347, '522' => 192, '9955' => 0 }
    relations.each do |id, expected|
      actual = $CK2_CHARACTERS.papal_relations[id]
      assert_equal expected, actual
    end
  end

  def test_chaplain_hash
    chaplains = { '155057' => '20802', '155029' => '155142' } # key employs val as chaplain
    chaplains.each do |host, chaplain|
      actual = $CK2_CHARACTERS.chaplain_index[host]
      assert_equal chaplain, actual
    end
  end

  def test_dynasty
    dynasties = { '33140' => '287', '140' => '752', '1316' => '651' }
    dynasties.each do |id, expected|
      actual = $CK2_CHARACTERS.characters[id].dynasty
      assert_equal expected, actual
    end
  end

  def test_old_holdings
    expected = %w[e_hre d_bavaria d_carinthia d_franconia
                  d_verona c_oberbayern c_leiningen
                ]
    actual = $CK2_CHARACTERS.characters['1314'].old_holdings
    assert_equal expected, actual
  end

  def test_character_religion
    religion = { '20662' => 'orthodox', '140' => 'catholic', '502636' => 'catholic' }
    religion.each do |character_id, expected|
      actual = $CK2_CHARACTERS.characters[character_id].religion
      assert_equal expected, actual
    end
  end

  def test_character_capital
    capitals = {'1316' => 'b_nassau', '140' => 'b_rouen', '122' =>"b_westminster" }
    capitals.each do |character_id, expected|
      actual = $CK2_CHARACTERS.characters[character_id].capital
      assert_equal expected, actual
    end
  end

  def test_character_prestige
    expecteds = {'20662' => '30.000', '122' => '40.000', '140' => '30.000'}
    expecteds.each { |id, value| assert_equal value, $CK2_CHARACTERS.characters[id].prestige }
  end

  def test_wealth
    expecteds = {'20662' => '63.72162', '122' => '69.44708', '140' => '995.36908'}
    expecteds.each { |id, wealth| assert_equal wealth, $CK2_CHARACTERS.characters[id].wealth}
  end

  def test_estimated_monthly_income
    expecteds = {'100522' => '2.46735', '122' => '4.27924', '140' => '1.73444'}
    expecteds.each { |id, income| assert_equal income, $CK2_CHARACTERS.characters[id].estimated_monthly_income }
  end

end
