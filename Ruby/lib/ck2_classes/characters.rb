class CK2_Characters
  
  def initialize
    puts "Reading CK2 characters..."
    @pope_id = $POPE
    @papal_relations = Hash.new
    @in_pope_char_info = false
    @in_relations = false
  end

  def add(line)
  	@in_pope_char_info = true if starting_pope_char_info?(line)
    @in_pope_char_info = false if new_char_info?(line) && @in_pope_char_info
    @in_relations = true if starting_papal_relations?(line)
    @in_relations = false if ending_papal_relations?(line)
    if @in_relations && @in_pope_char_info
      puts line
    end

  end

  def starting_pope_char_info?(line)
  	line =~ /^\t#{@pope_id}=/
  end

  def new_char_info?(line)
    line =~ /^\t\d+=/ && !(line =~ /^\t#{$POPE}=/)
  end

  def starting_papal_relations?(line)
    line =~ /^\t\t\tally=/ && @in_pope_char_info
  end

  def ending_papal_relations?(line)
    line =~ /^\t\t\tenemy=/ && @in_pope_char_info
  end

end