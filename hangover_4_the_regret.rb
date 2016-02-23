

class Player
	attr_accessor :player_health, :player_attack, :player_defense, :player_inventory
	def initialize
		@player_health = 20
		@player_attack = 10
		@player_defense = 10
	end

	@player_inventory = []

	def take(item)
		@player_inventory.push(item)
	end

	def look
		puts room.description
	end

	def check_inventory
		puts player_inventory
	end

end

	#class Baron
	#include Player
	#attr_accessor :baron_health

	#def initialize
		#@player_health = player_health
		#@player_attack = player_attack
	#	@player_defense = player_defense
	#end

		#if @player_attack >= 20 || @player_defense >= 15
			#@baron_health = 25
		#elsif @player_attack >= 20 && @player_defense >=15
			#@baron_health = 20
		#else
			#@baron_health = 30
		#end

	#end



class Room

def Room_1
		prompt()
		object = gets.chomp.upcase
		direction = gets.chomp.upcase
	
	case direction
	when 'NORTH'
		Room_2
	when 'WEST'
		Room_3
	when 'TROGDOR'
		puts "Really? You had to know you'd lose a fight with The Burninator. You're dead."
		you_lose
	else
		error_message
	end

	case object
	when 'FLAGON'
		puts "It seems like there yet be some moonshine left in this here flagon! Will ye drink it? Type 'y/n'. "
		choice = gets.chomp.downcase
			if choice == 'y'
				@player_attack += 5
				puts "Your attack power has increased by 5, because you're an aggressive drunk. Your attack is now #{attack}."
				take(flagon)
			else
				Room_1
			end
	when 'HAYSTACK'
		puts "'Suspicious: def. An object which, in the context of this game, will almost certainly kill you.' You're dead."
		you_lose
	when 'ROCK'
		take(rock)
		"You have put the rock into your inventory."
	else
		error_message
	end

end

def Room_2
	puts "Looks like the kitchen. Inside, you see a truly enormous carving KNIFE, some CHICKEN, and a bottle of BOURBON. Exits are NORTH, SOUTH, and SOUTHWEST."

direction = gets.chomp.upcase
object = gets.chomp.upcase

case direction
when 'NORTH'
	Room_4
when 'SOUTH'
	Room_1
when 'SOUTHWEST'
	Room_3
else
	error_message
end

case object
	when 'KNIFE'
		puts "Good thinking grabbing the stabby looking thing. Your attack power has increased by 5."
		take(knife)
		@player_attack += 5
	when 'CHICKEN'
		puts "Your defense power has increased because... chicken."
		take(chicken)
		@player_defense += 5
	when 'BOURBON'
		puts "YE ARE EVEN MORE AGGRO."
		take(bourbon)
		@player_attack += 5
	else
		error_message
end

end

def Room_3
	puts "You've reached the bathroom, and are confronted by an odour most foule. You see some BANDAGES, ASPIRIN, and a TOASTER floating inside of a bathtub. Exits are KANYE'S DAUGHTER and EAST."

direction = gets.chomp.upcase
object = gets.chomp.upcase

case direction

when 'NORTH WEST'
	Room_2
when 'EAST'
	Room_1
else
	error_message
end

case object

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
end

end

def Room_4
	puts "You're in some sort of weird antechamber. There doesn't appear to be anything in here. Exits are NORTH and DENNIS."

direction = gets.chomp.upcase

case direction

when 'NORTH'
	Room_5
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
end

end

def Room_5
	trigger_boss_battle
end

end

class Map

end


class Game
	def initialize
		start()
end

	def prompt
  	print "Enter command > "
  	answer = gets.chomp
	end
	

	def start
		Room.new
		Player.new
		puts "You awake to find yourself in a dark, musty room. In this room are an empty FLAGON, a suspicious looking HAYSTACK, and a sharp ROCK. 
		Visible exits are NORTH, WEST, and TROGDOR."
		Room_1
	end

	def trigger_boss_battle
		puts "You've encountered the fearson Baron Von Schneckeldorfing. You must roll the direction
		to determine your fate. Roll higher than the Baron to chip away at his health. If your roll is lower, you're hit instead.
		You lose if your health reaches 0. Your health is #{player_health}."
		Baron.new
		dice_roll
	end

	def you_win
		puts "You've escaped the dungeon in (mostly) one piece! Congrats!"
	end

	def you_lose
		puts "Game Over."
		#alive?! = false
	end

	def dice_roll
		player_roll = 1 + rand(6)
		baron_roll = 1 + rand(6)

	until @player_health <= 0 || @baron_health <= 0

		if player_roll > baron_roll
			baron_health -= player_roll
		else
			player_health -= baron_roll
		end
		puts "You rolled a #{player_roll}. The Baron rolled a #{baron_roll}. Your health is now #{player_health}. The baron's health is #{baron_health}."
	end

def error_message
		puts "That's not a valid choice. Try again."
	end
end




end

Game.new