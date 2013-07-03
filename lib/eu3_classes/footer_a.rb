class EU3_Footer_A

  def initialize

  end

  def write(location)
    location.puts "income_statistics=\n{\n}\nnation_size_statistics=\n{\n}"
    location.puts "inflation_statistics=\n{\n}"
  end

end