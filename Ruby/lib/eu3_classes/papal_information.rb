class EU3_Papal_Information
  attr_accessor :papal_relations, :papal_controller

  def initialize(titles, characters) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @papal_relations = sort(characters.papal_relations)
    @papal_controller = get_papal_controller(titles, characters)
  end

  def write(location)
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

end
