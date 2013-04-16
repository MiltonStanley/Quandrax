class EU3_Papal_Information
  attr_accessor :cardinals

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = create_cardinals(titles, papal_allies)
  end

  def write(location)
  end

  def create_cardinals(titles, cardinals)
    cardinals = convert_to_titles(titles, cardinals)
  end

end