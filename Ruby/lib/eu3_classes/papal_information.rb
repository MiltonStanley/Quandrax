class EU3_Papal_Information
  attr_accessor :cardinals

  def initialize(titles, characters) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = sort(characters.papal_relations)
  end

  def write(location)
  end

end