class EU3_Papal_Information

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = papal_allies
    @cardinals = convert_ids_to_titles(@cardinals, titles)
    @cardinals = convert_titles_to_tags(@cardinals, $TM_CK2_EU3)
    @cardinals = sort_cardinals(@cardinals)
    @cardinals.each { |key, val| puts "#{key} - #{val}"}
  end

  def sort_cardinals(cardinals)
    # Convert to array of 2-member arrays (key->val becomes [key, val], etc.)
    #   and then sort arrays by index 1 (the relations w/ pope), highest FIRST
      _temp_hash = cardinals.sort { |a, b| b[1]<=>a[1] }
    # Convert to 1-dimensions ([[val, val],...] becomes [val, val, ...])
      _temp_hash.flatten!
    # Then convert it back to a hash, this time sorted highest relation first
      _temp_hash = Hash[*_temp_hash]
    # Now add to cardinals as appropriate
    _temp_hash
  end

  def convert_ids_to_titles(cardinals, titles)
    _temp_hash = Hash.new   # Can't change cardinals in block
    cardinals.each do |key, val|  #  ID 1
      titles.each do |a_title|    
        if a_title.holder_id == key
          if a_title.name =~ /^b_/
            _temp_hash[a_title.liege] = val
          else
            _temp_hash[a_title.name] = val
            break
          end
        end
      end
    end
    _temp_hash
  end

  def convert_titles_to_tags(cardinals, tag_map)
    _temp_hash = Hash.new
    cardinals.each { |key, val| _temp_hash[tag_map[key]] = val }
    _temp_hash
  end

end