require 'iconv' # This is deprecated in 2.0.0, I think, but should work for now

require './lib/tracker.rb'    # Handles data from files and figuring out what to do with it
## Load CK2 Classes
require './lib/ck2_classes/header'
require './lib/ck2_classes/dynasties'
require './lib/ck2_classes/characters'
require './lib/ck2_classes/id'
require './lib/ck2_classes/religious_authority'
require './lib/ck2_classes/provinces'
require './lib/ck2_classes/titles'
require './lib/ck2_classes/diplomacy'
require './lib/ck2_classes/combat'
require './lib/ck2_classes/war'
require './lib/ck2_classes/active_war'
require './lib/ck2_classes/footer'
## Load EU3 Classes
require './lib/eu3_classes/header'
require './lib/eu3_classes/imperial_information'
require './lib/eu3_classes/defenders_of_the_faith'

def load_file(extension)
  filename = Dir.new(Dir.getwd).each { |file| break file if file.include?(extension) }
  if filename.class == Dir
    puts
    puts "No file found!"
    puts "See the help documentation at http://www.github.com/MiltonStanley/Quandrax for usage."
    Kernel.exit
  end
  file_name, _ = filename.split('.',2)
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
  tracker = Tracker.new
 # make_section_objects
  while line = file.gets
    line = line.unpack("C*").pack("U*")
    line.chomp!; next if line.nil?
    tracker.update(line)
  end
end

def make_classes
  $CK2_HEADER = CK2_Header.new
  $CK2_DYNASTIES = CK2_Dynasties.new
  $CK2_CHARACTERS = CK2_Characters.new($POPE)
  $CK2_ID = CK2_ID.new
  $CK2_TITLES = CK2_Titles.new($HRE)
end

###############################################################################
# 
# THESE FUNCTIONS TO TEST ABILITY OF PROGRAM TO COMBINE TEMPLATES WITH 
# PROGRAM-GENERATED FILES INTO USABLE SAVE FILES
#
###############################################################################

def write_file(new_file)
  $EU3_HEADER = EU3_Header.new($CK2_HEADER)
  $EU3_HEADER.write(new_file)
  #print_from_temp(new_file, './lib/templates/rebels.tmp')if $REBELS
  $EU3_IMPERIAL_INFO = EU3_Imperial_Information.new($CK2_TITLES)
  $EU3_IMPERIAL_INFO.write(new_file)
  $EU3_DEFENDERS_OF_THE_FAITH = EU3_Defenders_of_the_Faith.new
  $EU3_DEFENDERS_OF_THE_FAITH.write(new_file)
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
  convert_to_ansi(new_file)

  $CK2_CHARACTERS.write
end

def print_from_temp(new_file, temp_name)
  temp_file = File.open(temp_name, 'r')
  while line = temp_file.gets
    new_file.puts line
  end
  temp_file.close
end

def convert_to_ansi(new_file)
  utf_string_stream = File.open(new_file).read
  new_file.close
  ansi_string_stream = Iconv.iconv("LATIN1", "UTF-8", utf_string_stream).join
  File.open(new_file, "w") { |f| f.puts ansi_string_stream }
end