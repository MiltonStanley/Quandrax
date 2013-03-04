require './lib/config.rb'     # Handles configuration file

def cli_parse

  finished = false
  until finished
    ARGV.each do |param|
      if param == '-g'
        ARGV.shift
        $PARSE_TO = ARGV[0].to_i
        ARGV.shift
      elsif param == '-u'
        make_config_file(true)
      elsif param.nil?
        finished = true 
      end
    end
  end

end

$PARSE_TO ||= 0