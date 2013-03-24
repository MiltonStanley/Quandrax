class CK2_Characters
  
  def initialize
    puts "Reading CK2 character section..."
    @papal_relations = Hash.new
    @in_pope_char_info = false
  end

  def add(line)
  	@in_pope_char_info = true if starting_pope_char_info?(line)
    @in_pope_char_info = false if new_char_info?(line) && @in_pope_char_info
  end

  def starting_pope_char_info?(line)
  	line =~ /^\t#{$POPE}=/
  end

  def new_char_info?(line)
    line =~ /^\t\d+=/ && !(line =~ /^\t#{$POPE}=/)
  end

end