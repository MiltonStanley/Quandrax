###################################################################
#
# Title: Quandrax
# Description:  The QUick ANd Dirty paRAdoX converter, a project to create a single, unified save game converter.
# Version: 0.1
# (c) 2012, Milton Stanley
#
###################################################################

{
=begin
  ########### WORK TO BE DONE #################
    -- Tag Map
    -- CK2->EU3 Province map
  DONE	A. Open old file	DONE
  DONE		1) extract player
  DONE		2) extract date
  DONE		3) extract province ID & add controller
  DONE		4) Tagify World and Player
  DONE  5) Flip world - convert it from World[ck2] = Province(eu3, controller) to World[eu3] = Province(ck2, controller)
    B. open new file
      WHILE run through new file; copy & paste, EXCEPT:
        a. replace player
        b. replace date
        c. when province is mapped 
          BRAINSTORM
          EU3ID is var read from new file
          replace = false -- we'll toggle with this, so we don't mess it up
          if $province_map.index(eu3ID) (returns either nil or the index eu3id is at)
            replace = true 
                *when we come to it* controller of eu3id = map[$province_map.index(pid)].controller
              replace = false
          else
            
            not found, so use the controller you have
          end
          
          CODE I USED TO TEST THIS
          
          class World
            def match?(eu3ID)
              $province_map.index(eu3ID)
            end
          end
          
          $eu3prov.each do |pid|
            if map.match?(pid)
              puts "#{pid} is ruled by #{map[$province_map.index(pid)].controller}"
            else
              puts "#{pid} is ruled by #{$eu3ruler[pid]}"
            end
          end	
      
=end
}

require './tag_map.rb'
require './prov_map.rb'

#### CLASSES ####

class Player
  attr_accessor :who, :date
    
  def debug
    puts "Player: #{@who}. Date: #{@date}"
  end	

  def tagify
    @who = $tag_map[@who]		
  end
  
end


class Province	# Province class - has an ID (EU3 location) and a controller (shifts in runtime - CK2 vassal - CK2 liege - EU3 tag)
  
  attr_accessor :id, :controller
  
  def initialize(id,controller)
    @id = id
    @controller = controller
  end

  def annex(newController)	# How we change controller at runtime
    @controller = newController unless @controller == $player.who  
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
  
  def vassalize		# Messy, yes. Loops makeSure times to make CK2 vassal into CK2 liege - it's a mess in game, so mess[ier] here
    makeSure = 2000
    while makeSure > 0
      self.each do |province|
      province.annex($liegeFromFile[province.controller]) if $liegeFromFile[province.controller] # Only change if controller is vassal
      end
    makeSure -= 1
    end
  end
  
  def tagify	# And finally, we convert the (hopefully) top level names to EU3 tags
    self.each do |province|
      province.annex($tag_map[province.controller]) unless $tag_map[province.controller].nil? # all of them, so no if statement
    end
  end
      
end


class String			# Add some helpful things to help program understand what a line is
    
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
    line = self
    title = line.sub("title=\"","").chop
    title unless title.nil?
  end
  
  def extractLiege			# Returns liege info from given line
    line= self
    liege = line.sub("liege=\"","").chop
    liege unless liege.nil?
  end
  
  def titleData?			# Returns bool if line contains "title"; add "controller" later for EU3 parsing
    self.include? "title=\""# or self.include? "controller=\""
  end
  
  def liegeData?			# Returns bool if line contains "liege="
    #self.include? "liege=\"" unless self.include? "de_jure_liege=\""
    self =~ /^liege=/
  end
  
  def usefulData?			# Returns bool if line is either province data OR title data
    self.parse.to_i > 0 || self.titleHeader? || self.playerData? || self.dateData?
    #self.titleHeader?
  end
  
  def dateData?			# Returns bool if line is current date
    self =~ /^date/
  end
  
  def extractDate			# Takes out "date" etc. and returns string with current date
    self.sub("date","")
  end
  
  def playerData?			# Returns bool if line is current player info
    self =~ /player_realm/
  end
  
  def extractPlayer			# Returns string with current player
    who = self.sub("player_realm","")
    who.gsub!("\"","")
  end		
  
  def titleHeader?			# Returns bool if line starts with a title
    self =~ $goodTitle
  end
  
  def provinceHeader?		# Returns bool if line is a province header
    self.to_i != 0
  end
  
  def load(currentDepth)	# Does the actual work of deciding what to do with the line
    if currentDepth == 1 && usefulData?	# Only want top level, province OR title data
      if self.provinceHeader?			# Will set $id to current province, so depth 2 "title" will be saved in Province.new
        $id = self.parse
        $rulerFromFile << nil if $need_ruler==true
        $need_ruler = true
      elsif self.titleHeader?
        $vassal = self.parse
      elsif self.playerData?
        $player.who = self.extractPlayer
        #puts $player.who
        #$player.who = "d_normandy"
      elsif self.dateData?
        $player.date = self.extractDate
      end			
    elsif currentDepth == 2 
      if self.titleData? 	# I only want "title" data to add
        $title = self.extractTitle
        $rulerFromFile << $title
        $need_ruler = false
      end
      if self.liegeData?
        liege = self.extractLiege
        #~ puts "Vassal:#{$vassal} - Liege:#{liege}"
        $liegeFromFile[$vassal] = liege.chomp
      end
    end
  end
  
  def validate
    line = self
    if !line.valid_encoding?
      line = line.unpack('C*').pack('U*')
    end
    line = line.chomp
    line.lstrip
  end
  
end
      

#### CONSTANTS ####
#$oldFile = File.open("short_form.rb",'r')
$oldFile = File.open("./workflow/WilliamBeginning.ck2",'r')

$goodTitle =  /^[bcdke]_\w+/	# RegEx for title data, meaning "beginning of string (^) is either a b,c,d,k,or e, and is then followed by an _,
            # and then one or more (+) word characters (\w)
depth = 1
$id = 0					# Current Province ID - will be integer from 1 - 929
$vassal = ""				# Vassal -
$title = ""				#
$rulerFromFile = Array.new	# Ruler is blank array; will populate as array[index] = string, where index is ck2 prov_id and string is ruler
$rulerFromFile << "NO_PROVINCE"	# Array is 0 indexed; provinces are 1, so push a blank string to start, so appending will line up
$liegeFromFile = Hash.new
$need_ruler = false
  
#$province_map = [0,370, 371, 372, 372, 372]

#### PROGRAM ####
map = World.new('ck2')	# Create World
$player = Player.new


while line = $oldFile.gets
  depth += 1 if line.depthUp?
  line = line.validate
  line.load(depth) if line.length > 1
  depth -= 1 if line.depthDown?
end


####~ Testing methods ####

$player.debug
map.populate	# Fill it up!
map.debug	
3.times { puts }

map.vassalize		# Convert all provinces to top-level liege
map.debug
3.times { puts }

$player.tagify	# And make them good EU3 tags
map.tagify		
$player.debug
map.debug
3.times { puts }

eu3 = map.flipflop
eu3.debug
