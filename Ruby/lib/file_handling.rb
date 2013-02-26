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
  puts "Loading #{filename}."
  old_file = File.open("./#{filename}",'r')
  puts "Creating #{file_name}.eu3."
  new_file = File.new("#{file_name}.eu3",'w')
  return old_file, new_file
end

def process_file(file)
  tracker = Tracker.new(0,0)
  puts "location: line"
  while line = file.gets
    line.chomp!; next if line.nil?
    tracker.update(line)
    break if tracker.line_number > $PARSE_TO unless $PARSE_TO == 0

    something = make_header(line)
    #command = eval("make_#{tracker.location}(line)")
    puts "#{tracker.location}: #{something}"
    #puts command
  end
end

###############################################################################
# 
# THESE FUNCTIONS TO TEST ABILITY OF PROGRAM TO COMBINE TEMPLATES WITH 
# PROGRAM-GENERATED FILES INTO USABLE SAVE FILES
#
###############################################################################

def stitch(new_file)
  print_out(new_file, 'header.tmp') if $HEADER
  print_out(new_file, 'rebels.tmp')if $REBELS
  print_out(new_file, 'imperial_info.tmp') if $IMPERIAL_INFO
  print_out(new_file, 'religious_info.tmp') if $RELIGIOUS_INFO
  print_out(new_file, 'papacy.tmp') if $PAPACY
  print_out(new_file, 'trade.tmp') if $TRADE
  print_out(new_file, 'province.tmp') if $PROVINCE
  print_out(new_file, 'nations.tmp') if $NATIONS
  print_out(new_file, 'diplomacy.tmp') if $DIPLOMACY
  print_out(new_file, 'combat.tmp') if $COMBAT
  print_out(new_file, 'active_war.tmp') if $ACTIVE_WAR
  print_out(new_file, 'previous_war.tmp') if $PREVIOUS_WAR
  print_out(new_file, 'footer_a.tmp') if $FOOTER_A
  print_out(new_file, 'japanese.tmp') if $JAPANESE
  print_out(new_file, 'footer_b.tmp') if $FOOTER_B
end

def print_out(new_file, temp_name)
  temp_file = File.open(temp_name, 'r')
  while line = temp_file.gets
    new_file.puts line
  end
  temp_file.close
end
