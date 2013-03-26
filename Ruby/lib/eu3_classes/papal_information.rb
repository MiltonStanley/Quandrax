class EU3_Papal_Information

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = Hash.new
    add__eligible_cardinals(papal_allies)
  end

  def add__eligible_cardinals(papal_allies)
    # Convert to array of 2-member arrays (key->val becomes [key, val], etc.)
    # and then sort arrays by index 1 (the relations w/ pope), highest FIRST
      papal_allies = papal_allies.sort { |a, b| b[1]<=>a[1] }
    # Convert to 1-dimensions ([[val, val],...] becomes [val, val, ...])
      papal_allies.flatten!
    # Highest relation will be first element (id, relation, id, relation, etc...)
      highest_relation = papal_allies[1]
    # Then convert it back to a hash, this time sorted highest relation first
      papal_allies = Hash[*papal_allies]
    # Now add to cardinals as appropriate
    papal_allies.each do |key, val|
      if @cardinals.length < 15 || val == highest_relation
        @cardinals[key] = val
      end
    end
  end

end