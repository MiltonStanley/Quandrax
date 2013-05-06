## Configuration methods
# 
# * Update tags for new countries that appear in the expansions
#

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

def legal_version?(version)
  (version == '1' || version == '2' || version == '3')
end

def extract_version(line)
  line.chomp!
  _, $VERSION = line.split('=')
  $VERSION
end

def get_version_from_user
  while true
    puts
    puts "What is the LATEST version you have installed?"
    puts "1) Base game/Napoleon's Ambition/In Nomine/EU3: Complete"
    puts "2) Heir to the Throne"
    puts "3) Divine Wind/EU3 Chronicles"
    print "Number: "
    version = $stdin.gets.chomp
    return version if legal_version?(version)
    puts
    puts "Invalid number, please try again"
  end
end

def update_tags(version)
  if version == '1'
    puts "Using settings for base game."
  elsif version == '2'
    update_tags_for_httt
  elsif version == '3'
    update_tags_for_dw  
  end
end

def write_version_to_file(version)
  print "Writing version to configuration file..."
  config_file = File.new('config_file.txt','w')
  config_file.puts "VERSION=" + version
  config_file.close
  puts "Complete!"
  update_tags(version)
end

def load_config_file
  print "Loading configuration file..."
  config_file = File.open('config_file.txt','r')
  while line = config_file.gets
    version = extract_version(line)
  end
  if legal_version?(version)
    puts "complete!"
    update_tags(version)
  else
    puts "error."
    make_config_file(false)
  end  
end

def make_config_file(manual_reconfig)
  #ARGV.shift if manual_reconfig # Kludgy - gets returns ARGV[0] for some reason later on.s
  puts "Configuration file corrupted or not found." unless manual_reconfig
  puts
  puts "Running configuration script. To re-configure later (say, to add an expansion),"
  puts "simply run Quandrax with the -u parameter like so:"
  puts "prompt$> ruby quandrax.rb -u"
  write_version_to_file(get_version_from_user) # Is this bad form? Passing function into another one?
end

def run_config
  manual_config = ARGV[0] == '-u'

  if !(File.exist? "./config_file.txt") || manual_config
    make_config_file(false)
  else
    load_config_file if File.exist? "./config_file.txt"
  end

end