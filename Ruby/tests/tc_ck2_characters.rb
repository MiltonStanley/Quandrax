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
      $CK2_CHARACTERS.characters.each do |a_character|
        if names[a_character.id]
          expected = names[a_character.id]
          actual = a_character.birth_name
          assert expected == actual, "Expected name #{expected} for character #{
          a_character.id}, got #{actual} instead"
        end
      end
    end

    def test_employer
      employers = { '70556' => nil, '140' => '140', '502636' => '93502' }
      $CK2_CHARACTERS.characters.each do |a_character|
        if employers[a_character.id]
          expected = employers[a_character.id]
          actual = a_character.employer
        assert expected == actual, "Expected employer #{expected} for character #{
        a_character.id}, got #{actual} instead"
        end
      end
    end

    def test_job_title
      job_titles = { '70556' => nil, '140' => 'job_marshal', '502636' => "job_chancellor" }
      $CK2_CHARACTERS.characters.each do |a_character|
        if job_titles[a_character.id]
          expected = job_titles[a_character.id]
          actual = a_character.job_title
        assert expected == actual, "Expected job title #{expected} for character #{
        a_character.id}, got #{actual} instead"
        end
      end
    end

    def test_alive
      alive = { '70556' => false, '140' => true, '502636' => true }
      total_alive = 0
      $CK2_CHARACTERS.characters.each do |a_character|
        total_alive += 1 if a_character.alive
        if alive[a_character.id]
          expected = alive[a_character.id]
          actual = a_character.alive
        assert expected == actual, "Expected alive to be #{expected} for character #{
        a_character.id}, got #{actual} instead"
        end
      end
      puts "#{total_alive} alive of #{$CK2_CHARACTERS.characters.length} total"
    end

    def test_friends_of_pope
      allies = { '100600' => 400, '140' => 347, '522' => 192}
      $CK2_CHARACTERS.characters.each do |a_character|
        if allies[a_character.id]
          expected = allies[a_character.id]
          actual = a_character.papal_relation_value
        assert expected == actual, "Expected papal relation level of #{
        expected} for character #{a_character.id}, got #{actual} instead"
        end
      end
    end

    def test_papal_relations_hash
      relations = { '100600' => 400, '140' => 347, '522' => 192, '9955' => 0 }
      $CK2_CHARACTERS.characters.each do |a_character|
        if relations[a_character.id]
          expected = relations[a_character.id]
          actual = $CK2_CHARACTERS.papal_relations[a_character.id]
        assert expected == actual, "Expected papal_relations hash to have level of #{
        expected} for character #{a_character.id}, got #{actual} instead"
        end
      end
    end

    def test_chaplain_hash
      chaplains = { '155057' => '20802', '155209' => '155142x' } # key employs val as chaplain
      $CK2_CHARACTERS.characters.each do |a_character|
        if chaplains[a_character.employer]
          expected = chaplains[a_character.employer]
          actual = $CK2_CHARACTERS.chaplain_index[a_character.employer]
        assert expected == actual, "Expected chaplain index to have employer_id #{
        expected} for character #{a_character.id}, got #{actual} instead"
        end
      end
    end

end
