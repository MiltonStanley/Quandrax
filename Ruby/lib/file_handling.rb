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