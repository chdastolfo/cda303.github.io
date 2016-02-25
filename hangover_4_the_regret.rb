class Player
	attr_accessor :player_health, :player_attack, :player_defense, :player_inventory, :baron_health
	
	def initialize
		@player_health = 20
		@player_attack = 10
		@player_defense = 10
		@baron_health = 30

		@player_inventory = []

		puts "\nPlayer's health is #{player_health}. Player's attack is #{player_attack} and player's defense is #{player_defense}."

		set_baron_health
	end

	def check_inventory
		puts @player_inventory
	end

	def take(item)
		@player_inventory.push(item)
		puts @player_inventory
	end

		def set_baron_health
		if player_attack > 19 || player_defense > 14
			@baron_health = 25
		elsif player_attack > 19 && player_defense >14
			@baron_health = 20
		else
			@baron_health = 30
		end
		puts "\nThe baron's health is #{baron_health}."
	end

	def attack_baron
	# Generate random number between 0 and 6
	# and round down to either 0 or 5
	# store resulting integer in variable roll
	player_roll = rand(6).floor
 
	player_damage = player_roll * 3
	puts "\nYou attack the Baron for #{player_damage} damage."
 
	@baron_health -= player_damage
 
	if @baron_health <= 0
		abort("\nYou defeated the Baron! Run the file to play again.")
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
 
	baron_damage = baron_roll * 3
	puts "\nBaron attacks you for #{baron_damage} damage."
 
	@player_health -= baron_damage
 
	if @player_health <= 0
		abort("The Baron has killed you. Run the file again to enact vengeance.")
	else
		puts "Your health: #{@player_health}hp"
		puts "\nContinue attacking? Y/N"
		choice = $stdin.gets.chomp.upcase
		if choice == 'Y'
			attack_baron
		else
			abort("You miss 100% of the shots you don't take. Game Over.")
		end
	end
end

end

class Game
	attr_accessor :player_health, :player_attack, :player_defense
	
	def initialize
		start
	end

	def prompt
  	print "Enter command > "
	end

	def start
		@player = Player.new
		room_1
	end

	def take(item)
		@player.take(item)
	end

	def set_baron_health
		@player.set_baron_health
	end

	def room_1
		puts "\n"
		puts "You awake to find yourself in a dark, musty room. In this room are an empty FLAGON, a suspicious looking HAYSTACK, and a sharp ROCK. 
		Visible exits are NORTH, WEST, and TROGDOR."
		puts "\n"
		prompt
		answer = $stdin.gets.chomp.upcase
	case answer
	when 'NORTH'
		room_2
	when 'WEST'
		room_3
	when 'TROGDOR'
		puts "\n"
		puts "Really? You had to know you'd lose a fight with The Burninator. You're dead."
		puts "\n"
		you_lose
	when 'FLAGON'
		puts "\n"
		puts "It seems like there yet be some moonshine left in this here flagon!"
			@player.player_attack += 5
			puts "\n"
			puts "Your attack power has increased by 5, because you're an aggressive drunk. Your attack is now #{@player.player_attack}."
			puts "\n"
			take("flagon")
			room_1
	when 'HAYSTACK'
		puts "'Suspicious: def. An object which, in the context of this game, will almost certainly kill you.' You're dead."
		you_lose
	when 'ROCK'
		take("rock")
		puts "\n"
		puts "You have put the rock into your inventory."
		puts "\n"
		room_1
	else
		error_message
		room_1
	end
end

def room_2
	puts "\n"
	puts "Looks like the kitchen. Inside, you see a truly enormous carving KNIFE, some CHICKEN, and a bottle of BOURBON. Exits are NORTH, SOUTH, and SOUTHWEST."
	puts "\n"
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
		@player.take("knife")
		@player.player_attack += 5
		puts "\n"
		puts "Good thinking grabbing the stabby looking thing. Your attack power has increased by 5. Your attack is now #{@player.player_attack}."
		puts "\n"
		room_2
	when 'CHICKEN'
		take("chicken")
		@player.player_defense += 5
		puts "\n"
		puts "Your defense power has increased because... chicken. Your defense is now #{@player.player_defense}."
		puts "\n"
		room_2
	when 'BOURBON'
		@player.take("bourbon")
		@player.player_attack += 5
		puts "\n"
		puts "YE ARE EVEN MORE AGGRO. Your attack is now #{@player.player_attack}."
		puts "\n"
		room_2
	else
		error_message
		room_2
end

end

def room_3
	puts "\n"
	puts "You've reached the bathroom, and are confronted by an odour most foule. You see some BANDAGES, ASPIRIN, and a TOASTER floating inside of a bathtub. Exits are KANYE'S DAUGHTER and EAST."
	puts "\n"
	prompt
	answer = $stdin.gets.chomp.upcase
case answer
when 'NORTH WEST'
	room_2
when 'EAST'
	room_1
when 'BANDAGES'
	take("bandages")
	@player.player_defense += 5
	puts "\n"
	puts "Your ability to not bleed to death has increased. Defense +5. Your defense is now #{@player.player_defense}."
	puts "\n"
	room_3
when 'ASPIRIN'
	puts "\n"
	puts "These will come in handy when you're hungover after all that bourbon you drank. But... not right now."
	puts "\n"
	take("aspirin")
	room_3
when 'TOASTER'
	puts "\n"
	puts "You should have checked whether that toaster was plugged in. Spoiler Alert: it was. Ye are verily dead."
	puts "\n"
	you_lose
else
	error_message
	room_3
end

end

def room_4
	puts "\n"
	puts "You're in some sort of weird antechamber. There doesn't appear to be anything in here. Exits are NORTH and DENNIS."
	puts "\n"
	prompt
		answer = $stdin.gets.chomp.upcase
case answer
when 'NORTH'
	room_5
when 'DENNIS'
	puts "\n"
	puts "You're confronted by a surly man named DENNIS. He asks you for the password. You've... got the password... right?"
	puts "\n"
	password = gets.chomp
		if password == "Christina is the greatest in the whole world."
			you_win
		else
			puts "\n"
			puts "That's not the password! Uh-oh... Dennis looks angry. He killed you. Better luck next time."
			puts "\n"
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
		#@baron = Baron.new	
		puts "You've encountered the fearson Baron Von Schneckeldorfing. You must roll the dice
		\nto determine your fate. You lose if your health reaches 0.
		\nYour health is #{@player.player_health}.
		\nYour attack is #{@player.player_attack}. Your defense is #{@player.player_defense}."
		set_baron_health
		@player.attack_baron
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

Game.new