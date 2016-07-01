def which_cheese

require 'csv'

puts "Hi! Here's what cheese you should eat and which adult beverage you should pair it with."

cheese = { "0": "monterey jack, blonde ale", 
	"1": "cheddar, pale ale", 
	"2": "gorgonzola, IPA", 
	"3": "sharp blue cheese, imperial IPA", 
	"4": "Lancashire, British-style bitter", 
	"5": "Port-Salut, amber ale",
	"6": "Mizithra (aged sheep cheese), Scotch ale", 
	"7": "Gouda, Altbier", 
	"8": "Washed-rind cheese like Franch Morbier, Abbey Dubel", 
	"9": "Triple-creme, Strong Golden Ale",
    "10": "Double Gloucester, Strong Golden Ale", 
    "11": "Stilton, Barley Wine", 
    "12": "Gruyere, Porter"}

whichcheese = cheese.values

request = puts whichcheese[rand(whichcheese.length)]

request

end

which_cheese()

def arr_of_cheeses 
	chz = CSV.read("/applications/mamp/htdocs/rampup/cheeses.csv")
	puts chz[rand(chz.length)]
end

arr_of_cheeses()