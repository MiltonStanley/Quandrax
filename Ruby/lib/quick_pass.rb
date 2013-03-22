def quick_pass(file)
  e_hre = ''
  in_e_hre_title_info = false # Have we found the start of the e_hre section?
  while line = file.gets
    line = line.unpack("C*").pack("U*")
    in_e_hre_title_info = true if is_e_hre?(line)  # We've started e_hre title info!
    if is_hre_holder?(line) && in_e_hre_title_info
      _, e_hre = split_key_value(line)
      in_e_hre_title_info = false
    end
  end
  e_hre.chomp
end


def is_e_hre?(line) # Is line the start of the e_hre titular info?
  line =~ /^e_hre=/ 
end

def is_hre_holder?(line)
  line.lstrip =~ /^holder=/
end
