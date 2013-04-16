class EU3_Papal_Information
  attr_accessor :cardinals

  def initialize(titles, papal_allies) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = create_cardinals(titles, papal_allies)
  end

  def write(location)
  end

  def create_cardinals(titles, papal_allies)
    cardinals = papal_allies
    cardinals = convert_to_titles(cardinals)
  end

  def convert_to_titles(cardinals)
    _temp = Hash.new
    cardinals.each do |title, relations|
      _temp[title] = relations
    end
    _temp
  end

end