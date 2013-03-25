# characters.rb
# 
# Holds Pertinent CK2 character info for future use
#
# MOST Important stuff is passed to the A_Character class Below

class CK2_Characters
  attr_accessor :pope_id, :pope_relations
  
  def initialize(pope)
    puts "Reading CK2 characters..."
    @pope_id = pope
    @papal_relations = Hash.new  # Key=id, Value=...value...
  end

  def add(line)
    if is_section_header?(line)
      # Do nothing
    elsif is_character_header?(line)
      @current_character = A_Character.new(line.chop, @pope_id)
    else
      @current_character.add(line, @papal_relations)  # Passes it on to A_Character's add
    end
  end

  def write
    @papal_relations = @papal_relations.sort { |a, b| a[1]<=>b[1] }
    @papal_relations.each { |id, relation| puts "#{id}: #{relation}"}
  end

  def is_section_header?(line)
    line == "character=" || line =~ /^\s*[{}]/ # 0+ whicespace, { or }
  end

  def is_character_header?(line)
    line =~ /^\t\d+=/
  end

end

###############################
#
# A_Character does most of the
# real heavy lifting
#
###############################

class A_Character

  def initialize(line, pope_id)
    @id, _ = line.strip.split("=",2)
    @pope_id = pope_id
    @reading_ally = false
    @friend_of_pope = false
  end

  def add(line, papal_relations)
    @reading_ally = true if is_ally_header?(line)
    @reading_ally = false if is_enemy_header?(line)
    @friend_of_pope = true if @reading_ally && is_pope_id?(line)
    add_papal_ally(line, papal_relations) if is_relation_value?(line) && @friend_of_pope
  end

  def add_papal_ally(line, papal_relations_list)
    _, value = split_key_value(line)
    papal_relations_list[@id] = value.to_i
    @friend_of_pope = false
  end  

  def is_ally_header?(line)
    line =~ /^\t\t\tally=/
  end

  def is_enemy_header?(line)
    line =~ /^\t\t\tenemy=/
  end

  def is_pope_id?(line)
    _, id = split_key_value(line)
    id == @pope_id
  end

  def is_relation_value?(line)
    key, _ = split_key_value(line)
    key =~ /^\s*(value)/
  end

end