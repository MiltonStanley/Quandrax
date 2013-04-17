class EU3_Papal_Information
  attr_accessor :cardinals, :papal_controller

  def initialize(titles, characters) # Title info, and allies of pope hash
    puts "Creating EU3 papacy section"
    @cardinals = sort(characters.papal_relations)
  end

  def write(location)
  end

  def get_papal_holder(titles, characters)
    a_cardinal = @cardinals.shift
    a_cardinal.each { |a| puts a}
    titles.holder_index.each do |title, holder_id|
      @papal_holder = title if a_cardinal[0] == holder_id && title =~ /^k/
    end
  end

end
