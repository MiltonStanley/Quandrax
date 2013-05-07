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

  def test_loading_all_nations
    # Make an array hold the names of all country files and get rid of . and .. entries
    directory_listing = Dir.entries('./lib/templates/countries')
    directory_listing.shift(2)
    # Make a hash where key = TAG and value = file name for that country's information
    nation_files = Hash.new
    directory_listing.each { |a_file| nation_files[a_file[0..2].upcase] = a_file }
    # Assert all nations include
    $EU3_NATIONS.nations.each do |tag|
      next if tag.nil?
      assert_not_nil nation_files[tag], "Did not find an entry for #{tag}!"
    end
  end

end