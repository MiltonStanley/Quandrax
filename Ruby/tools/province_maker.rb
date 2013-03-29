temp_file = File.open('../lib/templates/province.tmp')
prov_stream = String.new

while line = temp_file.read
  prov_stream << line
end

puts prov_stream.length