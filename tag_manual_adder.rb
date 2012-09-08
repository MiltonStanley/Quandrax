# Will take list of tags from tag_map and list from tag_crawler and fill in the blanks (prompting)

$debug = ARGV[0]
$debug ||= false

welcome = "This will output the amount of work left to do" if $debug
welcome = "There is no error checking. Press enter on a blank line to end."

require "./tag_map"
$counties = $tag_map

2.times { puts } 
puts welcome
2.times { puts }

$full_list = File.open("title_list.txt","r")
$work_hash = {}

class Hash
  
# Public: Sort a Hash alphabetically by key. It sets up an Array of keys, sorts that, then iterates over
# that to append the keys from the original Hash to the new one.
#
# Example:
#
# sorted = {'b' => "bee", 'a' => 'ale}.sort
#   # => {'a' => 'ale, 'b' => "bee"}
#
# Returns the sorted hash
  def sort      
    sorter = []     # Set up blank array
    self.each_key { |key, value| sorter << key }  # Cycle through Hash self, add each key to the sorter array
    sorter = sorter.sort    # Sort that array (a
    sorted_self = {}        # Set up blank hash
    sorter.each do |key|    # Go through sorted array, extract key
      sorted_self[key] = self[key]    # Put self[key] in sorted_self[key] - this is sorted, because array is guiding us
    end
    sorted_self   # Return sorted self
  end
  
# Public: Remove a Hash pair and append to another Hash if the key begins with the given character
#
# receiver - the new Hash
# char     - the character to use
#
# Example:
#
# {"one" => 1, "two" => 2}.extract!(new_hash,'t')
#   # => new_hash = {"two" => 2}
#
# Returns the new hash  
  def extract!(receiver,char)
    self.each do |title, tag|
      receiver[title] = tag if title[0] == char
    end
    self.delete_if { |title,tag| title[0] == char }
    receiver
  end
  
end

class String
  
  def important?  # Returns bool: line doesn't start with # and has SOME length
    self[0] != "#" && self.length > 1
  end
  
  def missing?
    ($tag_map.has_key?(self)==false)
  end
  
end

class File
  
  def process
  
    if $debug
      found = 0
      missing = 0
      titles = 0
      while line = $full_list.gets
        titles += 1
        line = line.chomp
        line, waste = line.split("\t")
        if line.important?
          $tag_map.has_key?(line) ? found += 1 : missing += 1
        end
      end
      Kernel.puts "Total: #{titles}. Found: #{found}. Missing #{missing}"

    else  # NOT debugging
      
      while title = $full_list.gets
        title = title.chomp
        title, waste = title.split("\t")
        if title.missing?
          Kernel.print "Tag for #{waste} --- #{title}: "
          tag = Kernel.gets
          tag = tag.chomp
          tag.upcase!
          break if tag == ""
          $work_hash[title] = tag
        end
      end
    end
  end

end

begin
$full_list.process  # Work through the file, either reporting work OR adding tags
ensure
  $full_list.close
end

begin
  $work_hash.each { |title, tag| $counties[title] = tag }
  
  $counties.extract!(empires = Hash.new,'e')
  $counties.extract!(kingdoms = Hash.new,'k')
  $counties.extract!(duchies = Hash.new,'d')
  title, tag = $counties.shift

  $new = File.open("tag_map.rb","w") unless $counties == nil?

  $new.puts "$tag_map = {"
  empires.each { |title, tag| $new.puts "\"#{title}\" => \"#{tag}\"," }
  kingdoms.each { |title, tag| $new.puts "\"#{title}\" => \"#{tag}\"," }
  duchies.each { |title, tag| $new.puts "\"#{title}\" => \"#{tag}\"," }
  $counties.each { |title, tag| $new.puts "\"#{title}\" => \"#{tag}\"," }
  $new.puts "\"#{title}\" => \"#{tag}\""
  $new.puts "}"

ensure  
  $new.close
end

