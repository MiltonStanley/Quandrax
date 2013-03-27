class EU3_Papal_Information

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = Hash.new
    add__eligible_cardinals(papal_allies)
    @cardinals = convert_ids_to_titles(@cardinals, titles)
    @cardinals = convert_titles_to_tags(@cardinals, $TM_CK2_EU3)
    @cardinals.each { |key, val| puts "#{key}=#{val}" }
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
      # Need 15 cardinals, BUT include ALL that have = values to #15 for fairness
      if @cardinals.length < 15 || val == @cardinals.values.last
        @cardinals[key] = val
      end
    end
  end

  def convert_ids_to_titles(cardinals, titles)
    _temp_hash = Hash.new   # Can't change cardinals in block
    cardinals.each do |key, val|  #  ID 1
      titles.each do |a_title|    
        if a_title.holder_id == key
          _temp_hash[a_title.name] = val
          break
        end
      end
    end
    _temp_hash
  end

  def convert_titles_to_tags(cardinals, tag_map)
    _temp_hash = Hash.new
    cardinals.each do |key, val|
      _temp_hash << { tag_map[key] = val
    end
    _temp_hash
  end

end