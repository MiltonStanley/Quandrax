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
end


###############################################################################
# 
# THESE FUNCTIONS TO TEST ABILITY OF PROGRAM TO COMBINE TEMPLATES WITH 
# PROGRAM-GENERATED FILES INTO USABLE SAVE FILES
#
###############################################################################

def write_file(new_file)
  print_out(new_file, './lib/template/header.tmp') if $HEADER 
  #eval("$#{$OLD_FILE_EXTENSION.upcase}_HEADER.print")
  $EU3_HEADER.write
  print_out(new_file, './lib/template/rebels.tmp')if $REBELS
  print_out(new_file, './lib/template/imperial_info.tmp') if $IMPERIAL_INFO
  print_out(new_file, './lib/template/religious_info.tmp') if $RELIGIOUS_INFO
  print_out(new_file, './lib/template/papacy.tmp') if $PAPACY
  print_out(new_file, './lib/template/trade.tmp') if $TRADE
  print_out(new_file, './lib/template/province.tmp') if $PROVINCE
  print_out(new_file, './lib/template/nations.tmp') if $NATIONS
  print_out(new_file, './lib/template/diplomacy.tmp') if $DIPLOMACY
  print_out(new_file, './lib/template/combat.tmp') if $COMBAT
  #print_out(new_file, './lib/template/active_war.tmp') if $ACTIVE_WAR
  #print_out(new_file, './lib/template/previous_war.tmp') if $PREVIOUS_WAR
  print_out(new_file, './lib/template/footer_a.tmp') if $FOOTER_A
  print_out(new_file, './lib/template/japanese.tmp') if $JAPANESE
  print_out(new_file, './lib/template/footer_b.tmp') if $FOOTER_B
end

def print_out(new_file, temp_name)
  temp_file = File.open(temp_name, 'r')
  while line = temp_file.gets
    new_file.puts line
  end
  temp_file.close
end
