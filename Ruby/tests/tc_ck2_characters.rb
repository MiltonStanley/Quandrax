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
  require './tests/setup_for_tests'
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
      $CK2_CHARACTERS.characters.each do |a_character|
        if alive[a_character.id]
          expected = alive[a_character.id]
          actual = a_character.alive
        assert expected == actual, "Expected alive to be #{expected} for character #{
        a_character.id}, got #{actual} instead"
        end
      end
    end

end
