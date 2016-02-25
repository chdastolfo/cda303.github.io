#require map.rb

class Player
	attr_accessor :player_health, :player_attack, :player_defense, :player_inventory
	
	def initialize
		@player_health = 20
		@player_attack = 10
		@player_defense = 10

		@player_inventory = []

		puts "Player's health is #{player_health}. Player's attack is #{player_attack} and player's defense is #{player_defense}."
	end

	def check_inventory
		puts @player_inventory
	end

	def take(item)
		@player_inventory.push(item)
	end

end

class Game
	def initialize
		start()
	end

	def prompt
  	print "Enter command > "
	end

	def start
		Player.new
		room_1
	end

	def take(item)
		@player_inventory.push(item)
	end

	def set_baron_health
		if @player_attack > 19 || @player_defense > 14
			@baron_health = 25
		elsif @player_attack > 19 && @player_defense >14
			@baron_health = 20
		else
			@baron_health = 30
		end
	end

	def room_1
		puts "You awake to find yourself in a dark, musty room. In this room are an empty FLAGON, a suspicious looking HAYSTACK, and a sharp ROCK. 
		Visible exits are NORTH, WEST, and TROGDOR."
		prompt
		answer = $stdin.gets.chomp.upcase
	case answer
	when 'NORTH'
		room_2
	when 'WEST'
		room_3
	when 'TROGDOR'
		puts "Really? You had to know you'd lose a fight with The Burninator. You're dead."
		you_lose
	when 'FLAGON'
		puts "It seems like there yet be some moonshine left in this here flagon!"
			@player.player_attack += 5
			puts "Your attack power has increased by 5, because you're an aggressive drunk. Your attack is now #{@player_attack}."
			take(flagon)
	when 'HAYSTACK'
		puts "'Suspicious: def. An object which, in the context of this game, will almost certainly kill you.' You're dead."
		you_lose
	when 'ROCK'
		@player.take(rock)
		puts "You have put the rock into your inventory."
		check_inventory
	else
		error_message
		room_1
	end
end

def room_2
	puts "Looks like the kitchen. Inside, you see a truly enormous carving KNIFE, some CHICKEN, and a bottle of BOURBON. Exits are NORTH, SOUTH, and SOUTHWEST."
	prompt
	answer = $stdin.gets.chomp.upcase
case answer
when 'NORTH'
	room_4
when 'SOUTH'
	room_1
when 'SOUTHWEST'
	room_3
	when 'KNIFE'
		puts "Good thinking grabbing the stabby looking thing. Your attack power has increased by 5."
		@player.take(knife)
		@player_attack += 5
		check_inventory
	when 'CHICKEN'
		puts "Your defense power has increased because... chicken."
		take(chicken)
		@player_defense += 5
		check_inventory
	when 'BOURBON'
		puts "YE ARE EVEN MORE AGGRO."
		@player.take(bourbon)
		@player_attack += 5
		check_inventory
	else
		error_message
		room_2
end

end

def room_3
	prompt
	puts "You've reached the bathroom, and are confronted by an odour most foule. You see some BANDAGES, ASPIRIN, and a TOASTER floating inside of a bathtub. Exits are KANYE'S DAUGHTER and EAST."
	answer = $stdin.gets.chomp.upcase
case answer
when 'NORTH WEST'
	room_2
when 'EAST'
	room_1
when 'BANDAGES'
	puts "Your ability to not bleed to death has increased. Defense +5."
	take(bandages)
	@player_defense += 5
when 'ASPIRIN'
	puts "These will come in handy when you're hungover after all that bourbon you drank."
	take(aspirin)
when 'TOASTER'
	puts "You should have checked whether that toaster was plugged in. Spoiler Alert: it was. Ye are verily dead."
	you_lose
else
	error_message
	room_3
end

end

def room_4
	puts "You're in some sort of weird antechamber. There doesn't appear to be anything in here. Exits are NORTH and DENNIS."
	prompt
		answer = $stdin.gets.chomp.upcase
case answer
when 'NORTH'
	room_5
when 'DENNIS'
	puts "You're confronted by a surly man named DENNIS. He asks you for the password. You've... got the password... right?"
	password = gets.chomp
		if password == "Christina is the greatest in the whole world."
			you_win
		else
			puts "That's not the password! Uh-oh... Dennis looks angry. He killed you. Better luck next time."
			you_lose
		end
	else
	error_message
	room_4
end
end

def room_5
	trigger_boss_battle
end

	def trigger_boss_battle
		Baron.new
		puts "You've encountered the fearson Baron Von Schneckeldorfing. You must roll the direction
		to determine your fate. Roll higher than the Baron to chip away at his health. If your roll is lower, you're hit instead.
		You lose if your health reaches 0. Your health is #{@player.player_health}."
		@baron.attack_baron
	end

	def you_win
		abort("You've escaped the dungeon in (mostly) one piece! Congrats! Run the file to play again.")
	end

	def you_lose
		abort("Game Over.")
	end

def error_message
		puts "That's not a valid choice. Try again."
	end
end

	#def dice_roll
	#	player_roll = 1 + rand(6)
	#	baron_roll = 1 + rand(6)
	#	puts "You rolled a #{player_roll}. The Baron rolled a #{baron_roll}. Your health is now #{player_health}. The baron's health is #{baron_health}."
	#end

class Baron

attr_accessor :baron_health

@baron_health = 30

def initialize
	#set_baron_health
end

def attack_baron
	# Generate random number between 0 and 6
	# and round down to either 0 or 5
	# store resulting integer in variable roll
	player_roll = rand(6).floor
 
	player_damage = player_roll * 5
	puts "\nYou attack the Baron for #{player_damage} damage."
 
	@baron_health -= player_damage
 
	if @baron_health <= 0
		puts "\nYou defeated the Baron!"
		you_win
	else
		puts "Baron's health: #{@baron_health}hp"
		defend_baron
	end
end
 
def defend_baron
	# Generate random number between 0 and 6
	# and round down to either 0 or 5
	# store resulting integer in variable roll
	baron_roll = rand(6).floor
 
	baron_damage = baron_roll * 5
	puts "\nBaron attacks you for #{baron_damage} damage."
 
	@player_health -= baron_damage
 
	if @player_health <= 0
		you_lose
	else
		puts "Your health: #{@player_health}hp"
		puts "\nContinue attacking? Y/N"
		choice = $stdin.gets.chomp.upcase
		if choice == 'Y'
			attack_baron
		else
			you_lose
		end
	end
end

end

Game.new