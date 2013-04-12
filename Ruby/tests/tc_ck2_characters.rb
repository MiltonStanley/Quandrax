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
  require './tests/setup_for_ck2_tests'
end

class TC_CK2Characters < Test::Unit::TestCase

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
          assert expected == actual, "Expected name #{expected} for character #{id}, got #{actual} instead"
      end
    end

    def test_employer
      employers = { '70556' => nil, '140' => '140', '502636' => '93502' }
      employers.each do |id, expected|
        actual = $CK2_CHARACTERS.characters[id].employer
        assert expected == actual, "Expected employer #{expected} for character #{id}, got #{actual} instead"
      end
    end

    def test_job_title
      job_titles = { '70556' => nil, '140' => 'job_marshal', '502636' => "job_chancellor" }
      job_titles.each do |id, expected|
        actual = $CK2_CHARACTERS.characters[id].job_title
        assert expected == actual, "Expected job title #{expected} for character #{id}, got #{actual} instead"
      end
    end

    def test_alive
      alive = { '70556' => false, '140' => true, '502636' => true }
      alive.each do |character_id, expected|
        actual = $CK2_CHARACTERS.characters[character_id].alive
        assert expected == actual, "Expected alive to be #{expected} for character #{character_id}, got #{actual} instead"
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
      chaplains.each do |employer, chaplain|
        actual = $CK2_CHARACTERS.chaplain_index[employer]
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

end
