class EU3_Papal_Information
  attr_accessor :papal_relations, :papal_controller, :cardinal_tags

  def initialize(titles, characters) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @papal_relations = sort(characters.papal_relations)
    @papal_controller = get_papal_controller(titles, characters)
    @cardinal_tags = get_cardinal_tags(titles)
  end

  def write(location)
    location.puts "papacy=\n{\n\tcontroller=\"#{@papal_controller}\""
    location.puts "\tcrusade_target=\"---\"\n\tcrusade_start=\"1.1.1\""
    location.puts "\tlast_excom=\"1.1.1\"\n\tpapacy_active=yes"
    # Followed cardinal information, multiple entries'
    location.puts '}'
  end

  def get_papal_controller(titles, characters)
    need_papal_controller = true
    shifted_papal_relations = Hash.new
    papal_controller = String.new
    while need_papal_controller
      cardinal_id, value = @papal_relations.shift           # Removes first element from @papal_relations...
      shifted_papal_relations[cardinal_id] = value          # And adds to shifted_papal_relations
      titles.holder_index.each do |title, holder_id|  # Cycle through holder_index
        if cardinal_id == holder_id && title =~ /^k/  # If we find a kind with same id as the cardinal,
          papal_controller = title                   # Set that title as the papal_controller
          need_papal_controller = false               # And signal we're done looping
        end
      end
    @papal_relations = shifted_papal_relations.merge @papal_relations   # Set @papal_relations back to what it was
    end
    $TM_CK2_EU3[papal_controller]
  end

  def get_cardinal_tags(titles)
    papal_relations = Hash.new
    # If I assign directly, it messes up the original and fails other tests
    @papal_relations.each { |id, val| papal_relations[id] = val }
    holder_index = titles.holder_index
    cardinals = Array.new
    # Add to cardinals hash, until we have all cardinals
    while cardinals.length < 15
      cardinal_id, _ = papal_relations.shift
      holder_index.each do |title, holder_id|
        if cardinal_id == holder_id
          tag = $TM_CK2_EU3[title]
          cardinals << tag unless cardinals.include?(tag) || tag.nil?
        end
      end
    end
    cardinals
  end

end
