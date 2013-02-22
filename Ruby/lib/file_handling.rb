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
  oldFile = File.open("./#{filename}",'r')
  puts "Creating #{file_name}.eu3."
  newFile = File.new("#{file_name}.eu3",'w')
  return oldFile, newFile
end