class CK2_Characters
  
  def initialize
    puts "Reading CK2 character section..."
  end

  def add(line)
  	puts line if starting_pope_char_info?(line)
  end

  def starting_pope_char_info?(line)
  	line =~ /^\t#{$POPE}=/
  end

end