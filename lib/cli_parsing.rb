# To use, uncomment "cli_parse" line in  quandrax.rb, and comment $PARSE_TO line in globals.rb

require './lib/config.rb'     # Handles configuration file

def cli_parse

  ARGV.each do |param|
    if param == '-p'
      ARGV.shift
      $PARSE_TO = ARGV[0].to_i
      ARGV.shift
    elsif param == '-u'
      manual_update = true
    elsif param.nil?
      puts "finished"
    end

  end

  $PARSE_TO ||= 0
  manual_update ||= false
  #make_config_file(true) if manual_update

end

