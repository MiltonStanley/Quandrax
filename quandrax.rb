{
=begin
		-- Tag Map
		-- CK2->EU3 Province map
	DONE	A. Open old file	DONE
	DONE		1) extract player
	DONE		2) extract date
	DONE		3) extract province ID & add controller
	DONE		4) Tagify World and Player
		B. open new file
			WHILE run through new file; copy & paste, EXCEPT:
				a. replace player
				b. replace date
				c. when province is mapped 
					BRAINSTORM
					EU3ID is var read from new file
					replace = false -- we'll toggle with this, so we don't mess it up
					if $province_mapping.index(eu3ID) (returns either nil or the index eu3id is at)
					  replace = true 
								*when we come to it* controller of eu3id = map[$province_mapping.index(pid)].controller
							replace = false
					else
						
						not found, so use the controller you have
					end
					
					CODE I USED TO TEST THIS
					
					class World
						def match?(eu3ID)
							$province_mapping.index(eu3ID)
						end
					end
					
					$eu3prov.each do |pid|
						if map.match?(pid)
							puts "#{pid} is ruled by #{map[$province_mapping.index(pid)].controller}"
						else
							puts "#{pid} is ruled by #{$eu3ruler[pid]}"
						end
					end	
			
=end
}

require './tag_map.rb'

#### CONSTANTS ####
#$oldFile = File.open("short_form.rb",'r')
$oldFile = File.open("WilliamBeginning.ck2",'r')

$goodTitle =  /^[bcdke]_\w+/	# RegEx for title data, meaning "beginning of string (^) is either a b,c,d,k,or e, and is then followed by an _,
						# and then one or more (+) word characters (\w)
depth = 1
$id = 0					# Current Province ID - will be integer from 1 - 929
$vassal = ""				# Vassal -
$title = ""				#
$rulerFromFile = Array.new	# Ruler is blank array; will populate as array[index] = string, where index is ck2 prov_id and string is ruler
$rulerFromFile << "NO_PROVINCE"	# Array is 0 indexed; provinces are 1, so push a blank string to start, so appending will line up
$liegeFromFile = Hash.new
	
$province_mapping = [370, 371, 372, 372, 372]
#~ $tag_map = {
	#~ "d_one" => "IRE",
	#~ "c_two" => "ENG",
	#~ "c_three" => "SPA",
	#~ "k_four" => "FRA",
	#~ "e_five" => "POR",
	#~ "d_normandy" => "ENG"
	#~ }


#### CLASSES ####

class Player
	attr_accessor :who, :date
		
	def debug
		puts "Player: #{@who}. Date: #{@date}"
	end	

	def tagify
    @who = $tag_map[@who.intern]		
	end

end

class Province	# Province class - has an ID (EU3 location) and a controller (shifts in runtime - CK2 vassal - CK2 liege - EU3 tag)
	
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
	
    def flipflop
    new_world = World.new
    self.each_index do |index|
      prov = self[index]
      if prov.id.class == Array
        #puts prov.id
        prov.id.each_index do |ck2|
          if new_world[prov.id[ck2]].nil?
            new_world[prov.id[ck2]] = Province.new(self.index(prov), prov.controller)
          else
            puts 'Already there!'
          end
        end
      else
        if new_world[prov.id].nil?
          new_world[prov.id] = Province.new(index, prov.controller)
        elsif new_world[prov.id].id.class == Fixnum
          _temp = new_world[prov.id].id
          new_world[prov.id].id = Array.new
          new_world[prov.id].id << _temp
          new_world[prov.id].id << index
          #new_world[prov.id] = Province.new(index, "ERROR ERROR")
        elsif new_world[prov.id].id.class == Array
          _temp = new_world[prov.id].id
          new_world[prov.id].id = Array.new
          _temp.each { |id| new_world[prov.id].id << id }
          new_world[prov.id].id << index
        end
      end
    end
    new_world
  end
  
	def populate		# Make the World object full of Provinces by pulling in ID map and Ruler map
		$province_mapping.each_index do |index|
			self[index] = Province.new($province_mapping[index],$rulerFromFile[index])
		end
	end
	
	def debug		# For testing - lets us look at Province objects inside in a clean way
		self.each do |province|
			puts "ID:#{province.id} -- Controller:#{province.controller}" unless province.nil?
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
			province.annex($tag_map[province.controller.intern]) unless $tag_map[province.controller.intern].nil? # all of them, so no if statement
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
	
	def process(currentDepth)	# Does the actual work of deciding what to do with the line
		if currentDepth == 1 && usefulData?	# Only want top level, province OR title data
			if self.provinceHeader?			# Will set $id to current province, so depth 2 "title" will be saved in Province.new
				$id = self.parse
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
			end
			if self.liegeData?
				liege = self.extractLiege
				#~ puts "Vassal:#{$vassal} - Liege:#{liege}"
				$liegeFromFile[$vassal] = liege.chomp
			end
		end
	end
		
end
			
#### PROGRAM ####
map = World.new	# Create World
$player = Player.new


while line = $oldFile.gets
	depth += 1 if line.depthUp?
	if !line.valid_encoding?
      line = line.unpack('C*').pack('U*')
  end
	line = line.chomp
  line.lstrip!
	line.process(depth) if line.length > 1
	depth -= 1 if line.depthDown?
end

####~ Testing methods ####
$player.debug
map.populate	# Fill it up!
map.debug	
map.vassalize		# Convert all provinces to top-level liege
map.debug

$player.tagify	# And make them good EU3 tags
map.tagify		
$player.debug
map.debug
