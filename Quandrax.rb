###############################################################################
# 
# Title:        Quandrax
# File:         Quandrax.rb
# Function:     Main program
# Description:  The QUick ANd Dirty paRAdoX converter, a project to create 
#               a single, unified save game converter.
# Author:       Milton Stanley
# Version:      1.1.0 - Ruby
# License:      Too complicated. You can use this all you want. To edit it,
#               you must do so through the Github page via pull requests, etc.
#               at http://www.github.com/MiltonStanley/Quandrax_1.1.0
###############################################################################

require './lib/tag_map.rb'
require './lib/prov_map.rb'
require './test.rb'

### CLASSES ###

class Player
  attr_accessor :titles, :date, :id
  
  def debug
    puts "Player: #{@titles[0]}"
    puts "ID: #{@id}"
    puts "Date: #{@date}"
    puts @titles.join(', ')
  end
  
  def convert_to_tags(tag_map)
    @titles.each_index do |title|
      @titles[title] = tag_map[@titles[title]]
    end
  end

end


class Province
  
  attr_accessor :old_id, :new_id, :controller
  
  def initialize(old_id, new_id, controller)
    @old_id = old_id
    @new_id = new_id
    @controller = controller
  end
  
  def new_controller(new_controller)
    @controller = new_controller
  end
  
  def debug
    puts "Province #{old_id} => #{new_id}, controller: #{@controller}"
  end
  
end


class World < Array
  
  attr_reader :game
  
  def initialize(game)
    @game = game
  end
  
  def create(province_map, controller_list)
    province_map.each_index do |index|
      self[index] = Province.new(index, province_map[index], controller_list[index])
    end
  end
  
  def debug
    puts "Game type: #{@game}"
    self.each do |province|
      next if province.nil?
      province.debug
    end
  end
  
end

### TESTING METHODS ###
puts "Starting Quandrax..."; puts
puts "Starting test..."
puts
me = Player.new
me.titles = ['d_normandy','k_england','e_scandinavia']
me.date = "1066.10.05"
me.id = '150'
prov = Province.new(1, 370, "NRM")

me.debug

me.convert_to_tags(TM_CK2_EU3)
me.debug
puts "Hit Enter to end..."
x = gets

=begin
prov.debug
map = World.new('CK2')
map.create(PM_CK2_EU3, RULERS)
puts map.game
map.debug 
=end

