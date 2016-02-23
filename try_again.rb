require_relative "combatable.rb"

class Player
	include Combatable
	attr_accessor :x_coord, :y_coord

	MAX_HIT_POINTS = 100

	def initialize
		initialize_stats(BASE_STATS.merge ({max_hit_points: MAX_HIT_POINTS
			}))


		@x_coord, @y_coord = 0, 0 
	end

	def print_status
		puts "*" * 80
		puts "HP: #{@health}/#{MAX_HIT_POINTS}"
		puts "AP: #{@attack}"
		puts "*" * 80
	end	
end

class Item
	def interact(player)
		puts "You pick up #{self}."

		perform_item_effect(player)
	end

	def to_s
		"a shiny awesome #{@type.to_s}"
	end
end

class Potion < Item
	def initialize
		@name = "potion"
	end

	def perform_item_effect(player)
		player.heal(10)
	end	
end

class Sword < Item
	def initialize
		@name = "sword"
	end

	def perform_item_effect(player)
		player.attack += 1
	end
end



class Baron
	attr_accessor :health, :attack

	MAX_HIT_POINTS = 30

	def initialize
		@health = MAX_HIT_POINTS
		@attack = 1
	end

	def alive?
		@health > 0
	end

	def hurt(amount)
		@health -= amount
	end

	def to_s
		"It's the Baron! Runnnnn!"
	end

	def interact(player)
		while player.alive?
			puts "You've hit the baron for #{player.attack} points."
			hurt(player.attack)
			break unless alive?
			player.hurt(@attack)
			puts "The Baron hits you for #{attack} points."
		end
	end

end

class Dungeon
	DUNGEON_WIDTH = 10
	DUNGEON_HEIGHT = 10

	def initialize
		@rooms = Array.new(DUNGEON_HEIGHT, Array.new(DUNGEON_WIDTH))
	end

	def move_entity_north(entity)
		entity.y_coord -= 1 if entity.y_coord > 0 
	end

	def move_entity_south(entity)
		entity.y_coord += 1 if entity.y_coord < DUNGEON_HEIGHT - 1
	end

	def move_entity_east(entity)
		entity.x_coord += 1 if entity.x_coord < DUNGEON_WIDTH - 1
	end

	def move_entity_west(entity)
		entity.x_coord -= 1 if entity.x_coord > 0 
	end

	def get_room_of(entity)
		@rooms[entity.x_coord][entity.y_coord] ||= Room.new
	end
end

class Room
attr_accessor :size, :content

	def initialize
	@content = get_content
	@size = get_size
	@adjective = get_adjective
	end

	def interact(player)
		if @content
		@content.interact(player)
		@content = nil
		end
	end

	def to_s
	"You are in a #{@size} room. It is #{@adjective}."
	end

	private

	def get_content
		[Baron, Item].sample.new
	end

	def get_size
		["small", "medium", "large"].sample
	end

	def get_adjective
		["adorbs", "hideous", "milquetoast"]
	end
end

Dir["lib/**.*"].each {|file| require_relative file }

class Game
	ACTIONS = [
		:north, :east, :south, :west, :look, :fight, :take, :status, :help
	]
	def initialize
		@dungeon = Dungeon.new
		@player = Player.new

	start_game
end

private
def start_game
		while @player.alive?
		@current_room = @dungeon.get_room_of(@player)

		print_status

		action = take_player_input
		next unless ACTIONS.include? action

		take_action(action)
		end
	end

def take_player_input
	print "What's the plan, Stan? "
	gets.chomp.to_sym
end

def print_status
	puts "You are at map coordinates [#{@player.x_coord}, #{@player.y_coord}.]"

	#puts @current_room
	#if @current_room.content
	#	puts "You see #{@current_coom.content}."
	#end
end

	def take_action (action)
		case action
		when :look
			print_status
		when :north
			@dungeon.move_entity_north(@player)
		when :east
			@dungeon.move_entity_east(@player)
		when :south
			@dungeon.move_entity_south(@player)
		when :west
			@dungeon.move_entity_west(@player)
		when :fight, :take
			@current_room.interact(@player)
		when :status
			@player.print_status
		when :help
			puts "You can enter one of the following commands."
			print ACTIONS
		end
	end
end
Game.new
