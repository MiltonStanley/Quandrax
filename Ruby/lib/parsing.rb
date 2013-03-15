

def parse_header(line)
  $EU3_HEADER.add(line)
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
  $TITLES.add(line)
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

def split_key_value(line)
  key, value = line.split('=',2)
end