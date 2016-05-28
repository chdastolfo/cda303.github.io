def grandma

puts 'HEY THERE SONNY. YOU CONTINUE TO DISAPPOINT ME.'
bye = 0
	while bye < 3
	answer = gets.chomp
	if answer == 'BYE'
		puts "THIS IS WHY YOUR MOTHER DOESN'T LOVE YOU."
		bye = (bye + 1)
	elsif answer == answer.upcase
		year = rand(1930..1980)
		puts "NO, NOT SINCE #{year}!"
		bye = 0
	else
		puts 'HUH? SPEAK UP SONNY!'
		bye = 0
		end
	end

end

grandma()