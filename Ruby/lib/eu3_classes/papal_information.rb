class EU3_Papal_Information

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = create_cardinals(titles, papal_allies)
  end

  def write(location)
    @cardinals.each { |tag| location.puts tag }

  end

  def create_cardinals(titles, papal_allies)
    cardinals = papal_allies
    cardinals = convert_ids_to_titles(cardinals, titles)
    cardinals = convert_titles_to_tags(cardinals, $TM_CK2_EU3)
    cardinals = sort_cardinals(cardinals)
    average_relation = get_average_relation(cardinals)
    cardinals = highest_relations(cardinals, average_relation)
    cardinals
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
    cardinals.each do |key, val|
      tag = tag_map[key]
      if _temp_hash[tag].nil?
        _temp_hash[tag] = val
      else
        _temp_hash[tag] = val unless _temp_hash[tag] > val
      end
    end
    _temp_hash
  end

  def get_average_relation(hash)
    total_relations = 0
    hash.each_value { |val| total_relations += val}
    average_relation = total_relations / hash.length
    average_relation
  end

  def highest_relations(hash, average_relation)
    _temp_array = Array.new
    hash.each do |tag, relations|
      break if _temp_array.length >= 15
      number_of_entries = relations / average_relation
      1..number_of_entries.times { _temp_array << tag } if number_of_entries > 1
      _temp_array << tag if number_of_entries <= 1
    end
    _temp_array    
  end

end