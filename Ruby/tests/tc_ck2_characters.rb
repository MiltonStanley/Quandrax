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

end
