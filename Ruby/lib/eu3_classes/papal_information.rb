class EU3_Papal_Information

  def initialize(titles, papal_relations) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = Hash.new
    create_cardinals(papal_relations)
  end

  def create_cardinals(papal_allies)
    papal_allies = papal_allies.sort { |a, b| a[1]<=>b[1] } # Converts to arary
  end

end