def quick_pass(file)
  in_e_hre_title_info = false # Have we found the start of the e_hre section?
  in_pope_info = false
  while line = file.gets
    line = line.unpack("C*").pack("U*")
    in_e_hre_title_info = true if is_e_hre?(line)  # We've started e_hre title info!
    in_pope_info = true if is_pope?(line)
    e_hre, in_e_hre_title_info = get_e_hre(line) if is_hre_holder?(line, in_e_hre_title_info)
    pope, in_pope_info = get_pope(line) if is_pope_holder?(line, in_pope_info)
  end
  return e_hre.chomp, pope.chomp
end

def is_e_hre?(line) # Is line the start of the e_hre titular info?
  line =~ /^e_hre=/ 
end

def is_pope?(line)
  line =~ /^k_papal_state=/
end

def is_hre_holder?(line, in_e_hre_title_info)
  line.lstrip =~ /^holder=/ && in_e_hre_title_info
end

def is_pope_holder?(line, in_pope_info)
  line.lstrip =~ /^holder=/ && in_pope_info
end

def get_e_hre(line)
  _, e_hre = split_key_value(line)
  return e_hre, false
end

def get_pope(line)
  _, pope = split_key_value(line)
  return pope, false
end