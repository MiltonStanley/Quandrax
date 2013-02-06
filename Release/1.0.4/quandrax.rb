###################################################################
#
# Title: Quandrax
# Description:  The QUick ANd Dirty paRAdoX converter, a project to create a single, unified save game converter.
# Version: 1.0.4
# (c) 2012, Milton Stanley
#
###################################################################

require './lib/tag_map.rb'
require './lib/prov_map.rb'

############################
# UGLY CONFIGURATION STUFF #
############################

def update_tags_for_httt
  $tag_map["c_murom"] = "MUR"
  $tag_map["d_kola"] = "NZH"
  $tag_map["c_nizhny_novgorod"] = "NZH"
  $tag_map["c_smolensk"] = "SMO"
  $tag_map["d_smolensk"] = "SMO"
  $tag_map["c_mstislavl"] = "SMO"
  $tag_map["k_mentese"] = "MEN"
  $tag_map["d_cibyrrhaeot"] = "MEN"
  $tag_map["d_anatolia"] = "MEN"
  $tag_map["d_thracesia"] = "MEN"
  $tag_map["d_cibyrrhaeot "] = "MEN"
  $tag_map["d_lykia"] = "MEN"
  $tag_map["c_attaleia"] = "MEN"
  $tag_map["c_rhodos"] = "MEN"
  $tag_map["c_lykia"] = "MEN"
  $tag_map["c_dorylaion"] = "MEN"
  $tag_map["c_ikonion"] = "MEN"
  $tag_map["c_sozopolis"] = "MEN"
  $tag_map["c_laodikeia"] = "MEN"
  $tag_map["k_saruhan"] = "SRU"
  $tag_map["c_lykandos"] = "SRU"
  $tag_map["c_tarsos"] = "SRU"
  $tag_map["c_adana"] = "SRU"
  $tag_map["c_teluch"] = "SRU"
  $tag_map["c_seleukeia"] = "SRU"
end

def update_tags_for_dw
  $tag_map["c_ulm"] = "ULM"
end

def config_redo(need_to_config)
  puts
  puts "Running configuration script. To re-configure later (say, to add an expansion),"
  puts "simply run Quandrax with the -u parameter like so:"
  puts "prompt$> ruby quandrax -u"
  while need_to_config
    puts
    puts "What is the LATEST version you have installed?"
    puts "1) Base game/Napoleon's Ambition/In Nomine/EU3: Complete"
    puts "2) Heir to the Throne"
    puts "3) Divine Wind/EU3 Chronicles"
    print "Number: "
    version = gets.chomp.to_i
    if version == 1
      need_to_config = true
      break
    elsif version == 2
      need_to_config = true
      break
    elsif version == 3
      need_to_config = true
      break
    else
      puts
      puts "Invalid number, please try again"
    end
  end
  config_file = File.new("config.txt", 'w')
  config_file.puts version
  config_file.close
end

# Check for config file
config_exists = File.exist? "./config.txt"

if !config_exists || ARGV[0] == '-u'
  ARGV.shift # Kludgy - gets doesn't work in config, it tries to use ARGV[0] for some reason
  need_to_config = false
  config_redo(true)
end

config_file = File.open("config.txt",'r')
puts "Loading config file..."
while version = config_file.gets.to_i
  if version == 1
    puts "Loading mapping files..."
  elsif version == 2
    puts "Updating mapping files for Heir to the Throne"
    update_tags_for_httt
  elsif version == 3
    puts "Updating mapping files for Divine Wind"
    update_tags_for_httt # Wish ruby cases allowed fallthrough
    update_tags_for_dw
  else
    puts "Your config file seems to be misconfigured."
    puts "Please rerun Quandrax with the -u parameter as such:"
    puts "prompt$> ruby quandrax -u"
    Kernel::exit
  end
end

###########################
# END CONFIGURATION STUFF #
###########################

=begin
#### CLASSES ####

class Player
  attr_accessor :who, :date, :id
    
  def debug
    puts "Player: #{@who}. ID: #{@id}. Date: #{@date}"
  end	

  def tagify
    @who = $tag_map[@who]		
  end
  
end


class Province	# Province class
  
  attr_accessor :id, :controller
  
  def initialize(id,controller)
    @id = id
    @controller = controller
  end

  def annex(newController)	# How we change controller at runtime
    @controller = newController
  end

end


class World < Array	# World class - is an Array made up of province objects
  
  attr_reader :game
  
  def initialize(game)
    @game = game
  end
  
  def flipflop
    new_world = World.new('eu3') if self.game == 'ck2'
    new_world = World.new('ck2') if self.game == 'eu3'
    self.each_index do |index|      # Iterate over each index (index = @game index)
      prov = self[index]                # prov = province at that index
      next if prov.nil? 
      new_province = prov.id                  # new_province = the OTHER game's id
      next if new_province.nil?
      
      # Does the current province become multiple provinces?      
      if new_province.class == Array      # -> Yes, it does
        new_province.each_index do |id|  # Cycle through the new province id's
          if new_world[new_province[id]].nil?     # Make sure the new province doesn't exist yet
            new_world[new_province[id]] = Province.new(self.index(prov), prov.controller)
          else
            # Will pull current ids, put in array, add new one, then put them all back in id
            puts 'Already there!'
          end
        end
     
     else  # -> no, there is 1:1 province matching
        if new_world[new_province].nil?   # The new province doesn't exist yet
          new_world[new_province] = Province.new(index, prov.controller)
        elsif new_world[new_province].id.class == Fixnum  # The new province exists, but only has 1 id
          _temp = new_world[new_province].id
          new_world[new_province].id = Array.new
          new_world[new_province].id << _temp << index
        elsif new_world[new_province].id.class == Array   # The new province exists, and has multiple id's
          new_world[new_province].id << index
        end
      end
    
    end
    new_world
  end
  
  def populate		# Make the World object full of Provinces by pulling in ID map and Ruler map
    $province_map.each_index do |index|
      self[index] = Province.new($province_map[index],$rulerFromFile[index])
    end
  end
  
  def debug		# For testing - lets us look at Province objects inside in a clean way
    puts "Game Type: #{@game}"
    self.each do |province|
      puts "#{self.index(province)} - ID:#{province.id} -- Controller:#{province.controller}" unless province.nil?
    end
    puts "------------------------------------------------------------"
  end
  
  def vassalize		# Messy, yes. It's a mess in game (look at Germany 1000AD-1900AD), so mess[ier] here
    makeSure = 2000
    while makeSure > 0
      self.each do |province|
        if !(province.controller == $player.who) && $liegeFromFile[province.controller]  
          province.annex($liegeFromFile[province.controller]) # Only change if controller is vassal
        end
      end
    makeSure -= 1
    end
  end
  
  def tagify	# And finally, we convert the (hopefully) top level names to EU3 tags
    self.each do |province|
      province.annex($tag_map[province.controller])
    end
  end
      
end


class String			# Add some helpful things to help program understand what a prov is
    
  def parse				# Returns self without {, }, or =
    chars = ['{','}','=']
    chars.each do |char|
      self.gsub!(char,'')
    end
    self
  end

  def depthUp?			# Returns bool based on presence of '{' char
    self.include? "{"
  end
  
  def depthDown?			# Same as above, but '}' char
    self.include? "}"
  end
  
  def extractTitle			# Removes # title=" # and the last char (should be a quotation mark
    prov = self
    title = prov.sub("title=\"","").chop
    title unless title.nil?
  end
  
  def extractLiege			# Returns liege info from given prov
    prov= self
    liege = prov.sub("liege=\"","").chop
    liege unless liege.nil?
  end
  
  def extractHolder
    prov = self
    liege = prov.sub('holder','').chop
    liege unless liege.nil?
  end
  
  def titleData?			# Returns bool if prov contains "title"; add "controller" later for EU3 parsing
    self.include? "title=\""
  end
  
  def liegeData?			# Returns bool if prov contains "liege="
    self =~ /^liege=/
  end
  
  def holderData?
    self =~ /^holder=/
  end
  
  def usefulData?			# Returns bool if prov is either province data OR title data
    self.parse.to_i > 0 || self.titleHeader? || self.playerData? || self.dateData?
  end
  
  def dateData?			# Returns bool if prov is current date
    self =~ /^date/
  end
  
  def extractDate			# Takes out "date" etc. and returns string with current date
    self.sub("date","")
  end
  
  def playerData?			# Returns bool if prov is current player info
    self =~ /player_realm/
  end
  
  def extractPlayer			# Returns string with current player
    who = self.sub("player_realm","")
    who.gsub!("\"","")
  end		
  
  def titleHeader?			# Returns bool if prov starts with a title
    self =~ $goodTitle
  end
  
  def provinceHeader?		# Returns bool if prov is a province header
    self.to_i != 0
  end
  
  def playerID?(depth, top_level_depth)
    depth == 2 && top_level_depth == "player" &&
                  self.include?("id=")
  end
  
  def load(currentDepth)	# Does the actual work of deciding what to do with the prov
    if currentDepth == 1
      if usefulData?	# Only want top level, province OR title data
        if self.provinceHeader?	
          $id = self.parse
          $rulerFromFile << nil if $need_ruler==true
          $need_ruler = true
        elsif self.titleHeader?
          $vassal = self.parse
        elsif self.playerData?
          $player.who = self.extractPlayer
        elsif self.dateData?
          $player.date = self.extractDate
        end	
      end
      $top_level_depth = self      
    elsif currentDepth == 2 
      if self.playerID?(currentDepth, $top_level_depth)
        $player.id = self.sub!('id=','')
      end
      if self.titleData? 	# I only want "title" data to add
        $title = self.extractTitle
        $rulerFromFile << $title
        $need_ruler = false
      end
      if self.liegeData?
        liege = self.extractLiege
        $liegeFromFile[$vassal] = liege.chomp
      end
      if self.holderData? && self.include?("=#{$player.id}")
        $liegeFromFile[$vassal] = $player.who
      end
    end
  end
  
  def build(currentDepth, world, dest)	# Does the actual work of deciding what to do with the prov
    line = self.chomp
    prov = line.to_i
    if currentDepth == 1 && prov > 0 # Only true for province data headers
      $eu3_id = prov
      dest.puts line
    elsif currentDepth == 2
      if !(world[$eu3_id].nil?)
        ruler = world[$eu3_id].controller
        if line.include?("owner=\"")
          line.sub!(/owner=\"[A-Z]+\"/,"owner=\"#{ruler}\"")
        elsif line.include?("controller=\"")
          line.sub!(/controller=\"[A-Z]+\"/,"controller=\"#{ruler}\"")
        end
        dest.puts line
      else
       dest.puts line
      end
    elsif currentDepth == 3
      discovery = "CNN ENG LEI"
      if line.include?('CNN ENG LEI') && line =~ /^discovered_by/
        line.sub!('CNN ENG LEI', "CNN ENG #{$player.who} LEI") unless discovery.include?($player.who)
      end  
      dest.puts line
    else
      dest.puts line
    end
  end
  
  def validate(deTab)
    prov = self
    if !prov.valid_encoding?
      prov = prov.unpack('C*').pack('U*')
    end
    prov = prov.chomp
    prov.lstrip if deTab
  end
  
end
      

#### CONSTANTS ####

begin
  filename = Dir.new(Dir.getwd).each do |file|
    break file if file.include?(".ck2")
  end
  file_name, file_extension = filename.split('.',2)
  
  $oldFile = File.open("./#{file_name}.ck2",'r')
  $templateFile = File.open('./lib/template.eu3','r')
  $newFile = File.new("#{file_name}.eu3",'w')

  $goodTitle =  /^[bcdke]_\w+/
  $id = 0					# Current Province ID - will be integer from 1 - 929
  $vassal = ""				# Vassal -
  $title = ""				#
  $rulerFromFile = Array.new	# Array to hold rulers; index = ck2 province, element = ruler
  $rulerFromFile << "NO_PROVINCE"	# Array is 0 indexed; provinces are 1; get them together
  $liegeFromFile = Hash.new
  $need_ruler = false
  $top_level_depth = ""
  depth = 1

  #### PROGRAM ####
  map = World.new('ck2')	# Create World
  $player = Player.new

  while prov = $oldFile.gets  # Load data from old save
    depth += 1 if prov.depthUp?
    prov = prov.validate(true)
    prov.load(depth) if prov.length > 1
    depth -= 1 if prov.depthDown?
  end

  map.populate	  # Make the map
  map.vassalize		# Convert all provinces to top-level liege
  map.tagify	    # And make them good EU3 tags
  $player.tagify	# Same with $player
  eu3 = map.flipflop  # Make eu3 map by flipping index/prov.id's
  $newFile.puts "date=#{$player.date}"
  $newFile.puts "player=\"#{$player.who}\""

  depth = 1
  $eu3_id = 0
  while prov = $templateFile.gets
    depth += 1 if prov.depthUp?
    prov.build(depth, eu3, $newFile)
    depth -= 1 if prov.depthDown?
  end

ensure
$oldFile.close
$templateFile.close
$newFile.close
end
=end