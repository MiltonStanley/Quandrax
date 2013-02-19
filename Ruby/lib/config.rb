# Configuration stuff for detecting expansions

=begin HOW IT SHOULD WORK

1. Test file found? //Verify// : make it
2. Verify:
  - Extract data
  - Verify that data - legal? Adapt files : Make it
3. Make it
  - While loop
    - until legal version submitted
  - Write to file
4. Adapt files

=end

def update_tags_for_httt
  puts "Updating mapping files for Heir to the Throne"
  TM_CK2_EU3["c_murom"] = "MUR"
  TM_CK2_EU3["d_kola"] = "NZH"
  TM_CK2_EU3["c_nizhny_novgorod"] = "NZH"
  TM_CK2_EU3["c_smolensk"] = "SMO"
  TM_CK2_EU3["d_smolensk"] = "SMO"
  TM_CK2_EU3["c_mstislavl"] = "SMO"
  TM_CK2_EU3["k_mentese"] = "MEN"
  TM_CK2_EU3["d_cibyrrhaeot"] = "MEN"
  TM_CK2_EU3["d_anatolia"] = "MEN"
  TM_CK2_EU3["d_thracesia"] = "MEN"
  TM_CK2_EU3["d_cibyrrhaeot "] = "MEN"
  TM_CK2_EU3["d_lykia"] = "MEN"
  TM_CK2_EU3["c_attaleia"] = "MEN"
  TM_CK2_EU3["c_rhodos"] = "MEN"
  TM_CK2_EU3["c_lykia"] = "MEN"
  TM_CK2_EU3["c_dorylaion"] = "MEN"
  TM_CK2_EU3["c_ikonion"] = "MEN"
  TM_CK2_EU3["c_sozopolis"] = "MEN"
  TM_CK2_EU3["c_laodikeia"] = "MEN"
  TM_CK2_EU3["k_saruhan"] = "SRU"
  TM_CK2_EU3["c_lykandos"] = "SRU"
  TM_CK2_EU3["c_tarsos"] = "SRU"
  TM_CK2_EU3["c_adana"] = "SRU"
  TM_CK2_EU3["c_teluch"] = "SRU"
  TM_CK2_EU3["c_seleukeia"] = "SRU"
end

def update_tags_for_dw
  puts "Updating mapping files for Divine Wind"
  update_tags_for_httt
  TM_CK2_EU3["c_ulm"] = "ULM"
end

def verify_config_file
  puts "Found"
end

def get_version_from_user
  while true
    puts
    puts "What is the LATEST version you have installed?"
    puts "1) Base game/Napoleon's Ambition/In Nomine/EU3: Complete"
    puts "2) Heir to the Throne"
    puts "3) Divine Wind/EU3 Chronicles"
    print "Number: "
    version = gets.chomp
    return version if (version == '1' || version == '2' || version == '3')
    puts
    puts "Invalid number, please try again"
  end
end

def write_version_to_file(version)
  print "Writing version to configuration file..."
  config_file = File.new('config_file.txt','w')
  config_file.puts "VERSION=" + version
  config_file.close
  puts "complete!"
end

def make_config_file(manual_reconfig)
  ARGV.shift if manual_reconfig # Kludgy - gets returns ARGV[0] for some reason later on.s
  puts "Configuration file not found." unless manual_reconfig

  puts "Running configuration script. To re-configure later (say, to add an expansion),"
  puts "simply run Quandrax with the -u parameter like so:"
  puts "prompt$> ruby quandrax.rb -u"
  write_version_to_file(get_version_from_user) # Is this bad form? Passing function into another one?


end


verify_config_file if File.exist? "./config_file.txt"
make_config_file(ARGV[0] == '-u') if !(File.exist? "./config_file.txt")

=begin
# KEEP THIS DATA FOR REFERENCE

def write_config_file(version)
  puts "Writing configuration file"
  config_file = File.new("config_file.txt", 'w')
  config_file.puts "VERSION=#{version}"
  config_file.close
end

def make_config_file
  puts "******* IN make_config_file **********"
  puts
  puts "Running configuration script. To re-configure later (say, to add an expansion),"
  puts "simply run Quandrax with the -u parameter like so:"
  puts "prompt$> ruby quandrax.rb -u"
  while true
    puts
    puts "What is the LATEST version you have installed?"
    puts "1) Base game/Napoleon's Ambition/In Nomine/EU3: Complete"
    puts "2) Heir to the Throne"
    puts "3) Divine Wind/EU3 Chronicles"
    print "Number: "
    version = gets.chomp
    if version == '1'
      write_config_file(version)
      break
    elsif version == '2'
      write_config_file(version)
      break
    elsif version == '3'
      write_config_file(version)
      break
    else
      puts
      puts "Invalid number, please try again"
    end
  end

end

def load_version
  file = File.open("./config_file.txt",'r')
  while line = file.gets
    unless line.nil?
      line.chomp!
      key, value = line.split('=')
    end
  end
  value ||= 0
end



valid_configuration = false

until valid_configuration
  puts "Validating configuration"
  version = load_version
  if version == 1
     puts "Loading mapping files..."
     valid_configuration = true
  elsif version == 2
      update_tags_for_httt
      valid_configuration = true
  elsif version == 3
      update_tags_for_dw
      valid_configuration = true
  else
      puts "Your config file seems to be misconfigured."
      make_config_file
  end
end

=end