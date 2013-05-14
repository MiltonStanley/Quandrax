class EU3_Papal_Information
  attr_accessor :papal_relations, :papal_controller, :cardinal_controllers,
                :cardinal_names, :cardinal_location_names, :cardinal_controller_tags,
                :cardinal_province_ids

  def initialize(titles, characters, provinces) # Title info, and allies of pope hash
    puts "Creating EU3 Papacy section"
    @papal_relations = sort(characters.papal_relations)
    @papal_controller = get_papal_controller(titles, characters)
    @cardinal_controllers, @cardinal_controller_tags = get_cardinal_controllers(titles, characters.characters)
    @cardinal_names = get_cardinal_names(titles.holder_index, characters)
    @cardinal_location_names = get_cardinal_location_names(titles.holder_index, characters.characters)
    @cardinal_province_ids = get_cardinal_province_ids(titles.liege_index, provinces)
  end

  def write(location)
    location.puts "papacy=\n{\n\tcontroller=\"#{@papal_controller}\""
    location.puts "\tcrusade_target=\"---\"\n\tcrusade_start=\"1.1.1\""
    location.puts "\tlast_excom=\"1.1.1\"\n\tpapacy_active=yes"
    write_cardinals(location)
    location.puts '}'
  end

  def write_cardinals(location)
    @cardinal_controller_tags.each_index do |index|
      location.puts "\tcardinal=\n\t{\n\t\tname=\"#{@cardinal_names[index]}\""
      location.puts "\t\tlocation=#{@cardinal_province_ids[index]}\n"
      location.puts "\t\tcontroller=\"#{@cardinal_controller_tags[index]}\""
      location.puts "\t\tid=\n\t\t{\n\t\t\tid=#{index+1}\n\t\t\ttype=42\n\t\t}"
      location.puts "\t}"
    end
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

  def get_cardinal_controllers(titles, characters)
    cardinal_titles = Array.new
    cardinal_tags = Array.new
    papal_relations = Hash.new
    @papal_relations.each { |id, relation| papal_relations[id] = relation}
    while cardinal_titles.length < 15
      cardinal_id, _ = papal_relations.shift
      titles.holder_index.each do |title, id|
        if id == cardinal_id && !(cardinal_tags.include? $TM_CK2_EU3[title])
          unless title =~ /^b_/ || characters[cardinal_id].religion != 'catholic'
            cardinal_titles << title
            cardinal_tags << $TM_CK2_EU3[title]
          end
          break
        end
      end
    end
  return cardinal_titles, cardinal_tags
  end


  def get_cardinal_names(holder_index, characters)
    names = Array.new
    @cardinal_controllers.each do |title|
      host = holder_index[title]
      chaplain = characters.chaplain_index[host]
      names << characters.characters[chaplain].birth_name
    end
    names
  end

  def get_cardinal_location_names(holder_index, characters)
    _locations = Array.new
    @cardinal_controllers.each do |title|
      id = holder_index[title]
      _locations << characters[id].capital
    end
    _locations
  end

  def get_cardinal_province_ids(liege_index, provinces)
    _ids = Array.new
    @cardinal_location_names.each do |title|
      liege = liege_index[title]
      provinces.each do |a_province|
        next if a_province.nil?
        _ids << a_province.ck2_id if a_province.title == liege
      end
    end
    _ids
  end

end
