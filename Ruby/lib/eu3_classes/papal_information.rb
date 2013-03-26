class EU3_Papal_Information

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = Hash.new
    create_cardinals(papal_allies)
  end

  def create_cardinals(papal_allies)
    # Convert to array of 2-member arrays (key->val becomes [key, val], etc.)
    # and then sort arrays by index 1 (the relations w/ pope)
      papal_allies = papal_allies.sort { |a, b| a[1]<=>b[1] }
    # Convert to 1-dimensions ([[val, val],...] becomes [val, val, ...])
      papal_allies.flatten! 
    highest_relation = papal_allies.last  # What is the best relation?
    papal_allies = Hash[*papal_allies.flatten]
  end

end