# characters.rb
# 
# Holds Pertinent CK2 character info for future use
#
# MOST Important stuff is passed to the A_Character class Below

class CK2_Characters
  attr_accessor :pope_id, :papal_relations, :characters, :chaplain_index
  
  def initialize(pope)
    puts "Reading CK2 characters..."
    @pope_id = pope
    @papal_relations = Hash.new  # Key=id, Value=...value...
    @characters = Hash.new
    @chaplain_index = Hash.new  # Key = MASTER, value = chaplain id
    @last_character = nil
    @current_character = nil
  end

  def add(line)
    if is_section_header?(line)
      # Do nothing
    elsif is_character_header?(line)      # We've found a new character header
      @last_character = @characters[@current_character] # So the former new guy is now the old guy (A_Title)
      @current_character = line.chop.lstrip          # And the new guy is now line.chop (String)
      unless @last_character.nil?          # Don't try this the first time through
        @papal_relations[@last_character.id] = @last_character.papal_relation_value   # Add @last_character's value to @papal_rel
        @chaplain_index[@last_character.employer] = @last_character.id if @last_character.job_title == 'job_spiritual' # Add to chaplain_index if it's a chaplain
      end
      @characters[@current_character] = A_Character.new(line, @pope_id)  # Add to character hash, key = id, value = a new A_Character
    else
      @characters[@current_character].add(line, @papal_relations)  # Add to the last A_Character in the array
    end
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
  attr_accessor :id, :relations_to_pope, :friend_of_pope, 
  :birth_name, :employer, :job_title, :alive, 
  :papal_relation_value, :dynasty, :old_holdings

  def initialize(line, pope_id)
    @id, _ = line.strip.split("=",2)
    @pope_id = pope_id
    @reading_ally = false
    @friend_of_pope = false
    @alive = true
    @papal_relation_value = 0  # Start with no relations
    @old_holdings = Array.new
  end

  def add(line, papal_relations)
    key, val = split_key_value(line)
    @birth_name = val.gsub('"','') if is_birth_name?(key)
    @employer = val.gsub('"','') if is_employer?(key)
    @job_title = val.gsub('"','') if is_job_title?(key)
    @alive = false if is_dead?(key)
    @reading_ally = true if is_ally_header?(line) # Line has "ally="
    @reading_ally = false if is_enemy_header?(line) # Line has "enemy=" which is AFTER allies
    @friend_of_pope = true if @reading_ally && is_pope_id?(line) # In ally section, id is pope's
    add_papal_ally(line, papal_relations) if is_relation_value?(line) && @friend_of_pope
    @dynasty = val.gsub('"','') if is_dynasty?(key)
  end

  def is_dynasty?(key)
    key =~ /^\t\t(dynasty)/
  end

  def add_papal_ally(line, papal_relations_list)
    _, value = split_key_value(line)
    @papal_relation_value = value.to_i
    @friend_of_pope = false
  end  

  def is_birth_name?(key)
    key =~ /^\t+(birth_name)/
  end

  def is_employer?(key)
    key =~ /^\t+(employer)/
  end

  def is_job_title?(key)
    key =~ /^\t+(job_title)/
  end

  def is_dead?(key)
    key =~ /^\t+(death_date)/
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