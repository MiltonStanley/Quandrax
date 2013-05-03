class EU3_Defenders_of_the_Faith

  def initialize
    puts "Creating EU3 Defenders of the Faith section"
  end  

  def write(location)
    location.puts "noreligion=\n{\n}\ncatholic=\n{\n}\nprotestant=\n{\n}\nreformed=\n{"
    location.puts "}\northodox=\n{\n}\nsunni=\n{\n}\nshiite=\n{\n}\nbuddhism=\n{\n}"
    location.puts "hinduism=\n{\n}\nconfucianism=\n{\n}\nshinto=\n{\n}\nanimism=\n{\n}"
    location.puts "shamanism=\n{\n}"
  end

end