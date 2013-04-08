def split_key_value(string)
  string.split('=',2)
end

def invert(array)
  _temp = Array.new
  array.each_index do |index|
    id = array[index]
    if id.class == Fixnum
      if _temp[id].nil?
        _temp[id] = index
      else
        _int = _temp[id]
        _temp[id] = Array.new
        _temp[id] << _int << index
      end
    elsif id.class == Array
      id.each_index { |indy| _temp[id[indy]] = index }
    end
  end
  _temp
end

def sort(hash)
  temp_hash = hash.sort { |a, b| b[1]<=>a[1] }
  # Convert to 1-dimensions ([[key, val],...] becomes [key,] val, ...])
  temp_hash.flatten!
  # Then convert it back to a hash, this time sorted highest value first
  temp_hash = Hash[*temp_hash]
  # Return it
  temp_hash
end

def parse_header(string)
  $CK2_HEADER.add(string)
end

def parse_dynasties(string)
  # Do nothing for now...
end

def parse_titles(string)
  $CK2_TITLES.add(string)
end

def parse_character(string)
  $CK2_CHARACTERS.add(string)
end

def parse_id(string)
  
end

def parse_religious_authority(string)
  
end

def parse_provinces(string)
  $CK2_PROVINCES.add(string)

end

def parse_diplomacy(string)
  
end

def parse_combat(string)

end

def parse_war(string) #not_love

end

def parse_active_war(string)

end

def parse_footer(string)

end