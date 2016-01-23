# I/O Exercises
#
# * Write a `guessing_game` method. The ocmputer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
	computers_num = rand(1..100)
	guess_count = 0

	while true do
		puts "guess a number"
		guess = gets.chomp.to_i
		puts guess
		guess_count += 1
		puts guess_count
		if guess > computers_num
			puts "too high"
		elsif guess < computers_num
			puts "too low"
		else 
			return
		end
	end
end


def line_shuffler
	puts "What filename should we open and shuffle?"
	filename = gets.chomp
	file = File.open(filename, "r")
	lines = file.readlines().shuffle
	new_file = File.open(filename + "-shuffled", "w")
	lines.each do |line|
		new_file.puts line
	end

	new_file.close()
end

line_shuffler