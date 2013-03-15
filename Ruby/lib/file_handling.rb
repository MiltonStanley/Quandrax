require './lib/parsing.rb'    # Handles data from files and figuring out what to do with it

def load_file(extension)
  filename = Dir.new(Dir.getwd).each { |file| break file if file.include?(extension) }
  if filename.class == Dir
    puts
    puts "No file found!"
    puts "See the help documentation at http://www.github.com/MiltonStanley/Quandrax for usage."
    Kernel.exit
  end
  file_name, file_extension = filename.split('.',2)
  puts
  print "Opening #{filename}..."
  old_file = File.open("./#{filename}",'r')
  puts "ok!"
  print "Creating #{file_name}.eu3..."
  new_file = File.new("#{file_name}.eu3",'w')
  puts "ok!"
  return old_file, new_file
end

def process_file(file)
  tracker = Tracker.new(0,0)
 # make_section_objects
  while line = file.gets
    line.chomp!; next if line.nil?
    command = tracker.update(line)
    break if command == 'break'
  end
end

def make_classes
  $EU3_HEADER = Header.new
  $TITLES = Titles.new
end


###############################################################################
# 
# THESE FUNCTIONS TO TEST ABILITY OF PROGRAM TO COMBINE TEMPLATES WITH 
# PROGRAM-GENERATED FILES INTO USABLE SAVE FILES
#
###############################################################################

def write_file(new_file)
  $EU3_HEADER.write(new_file)
  #print_from_temp(new_file, './lib/templates/rebels.tmp')if $REBELS
  print_from_temp(new_file, './lib/templates/imperial_info.tmp') if $IMPERIAL_INFO
  print_from_temp(new_file, './lib/templates/religious_info.tmp') if $RELIGIOUS_INFO
  print_from_temp(new_file, './lib/templates/papacy.tmp') if $PAPACY
  print_from_temp(new_file, './lib/templates/trade.tmp') if $TRADE
  print_from_temp(new_file, './lib/templates/province.tmp') if $PROVINCE
  print_from_temp(new_file, './lib/templates/nations.tmp') if $NATIONS
  print_from_temp(new_file, './lib/templates/diplomacy.tmp') if $DIPLOMACY
  print_from_temp(new_file, './lib/templates/combat.tmp') if $COMBAT
  #print_from_temp(new_file, './lib/templates/active_war.tmp') if $ACTIVE_WAR
  #print_from_temp(new_file, './lib/templates/previous_war.tmp') if $PREVIOUS_WAR
  print_from_temp(new_file, './lib/templates/footer_a.tmp') if $FOOTER_A
  print_from_temp(new_file, './lib/templates/japanese.tmp') if $JAPANESE
  print_from_temp(new_file, './lib/templates/footer_b.tmp') if $FOOTER_B
end

def print_from_temp(new_file, temp_name)
  temp_file = File.open(temp_name, 'r')
  while line = temp_file.gets
    new_file.puts line
  end
  temp_file.close
end
