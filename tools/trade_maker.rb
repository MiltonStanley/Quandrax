ofile = File.open('../lib/templates/trade.tmp', 'r')
nfile = File.open('../lib/eu3_classes/trade.rb','w')
string = ofile.read

nfile.puts 'class EU3_Trade'
nfile.puts
nfile.puts "\tdef write(location)"
nfile.puts "\t\tlocation.puts \"#{string}\""
nfile.puts "\tend"
nfile.puts
nfile.puts "end"