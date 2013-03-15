def split_key_value(line)
  key, value = line.split('=',2)
end

def parse_header(line)
  $CK2_HEADER.add(line)
end

def parse_dynasties(line)
  # Do nothing for now...
end

def parse_character(line)

end

def parse_id(line)
  
end

def parse_religious_authority(line)
  
end

def parse_provinces(line)
  
end

def parse_titles(line)
  $CK2_TITLES.add(line)
end

def parse_diplomacy(line)
  
end

def parse_combat(line)

end

def parse_war(line) #not_love

end

def parse_active_war(line)

end

def parse_footer(line)

end