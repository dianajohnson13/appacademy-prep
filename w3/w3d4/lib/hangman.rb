class Hangman
	attr_reader :guesser, :referee, :board

	def initialize(players)
		@guesser = players[:guesser]
		@referee = players[:referee]
	end

	def board
		@board
	end

	def setup
		secret_length = referee.pick_secret_word
		guesser.register_secret_length(secret_length)
		@board = Array.new(secret_length)
	end

	def take_turn
		guess = guesser.guess(board)
		matches = referee.check_guess(guess)
		unless matches.empty?
			update_board(matches, guess)
		end
		guesser.handle_response(guess, matches)
	end

	def update_board(matches, guess)
		matches.each do |i|
			board[i] = guess
		end
	end

	def display_board
		display_board = ""
		board.each do |space|
			if space.nil?
				display_board << "_"
			else
				display_board << space
			end
		end
		display_board
	end

	def play
		puts "Let's play Hangman!"
		puts "#{guesser.name} will guess the word, and #{referee.name} will be the referee."
		setup

		10.times do |guess|
			if board.include?(nil)
				p display_board
				take_turn
			else
				puts "#{guesser.name} wins!! The word was #{board.join}"
				return
			end
			puts "#{guess + 1} guesses out of 10 have been made."
		end

		puts "#{guesser.name} looses! The word was #{referee.get_word}"
	end

end

class HumanPlayer
	attr_reader :name

	def initialize(name)
		@name = name
		@used_letters = []
	end
	
	def register_secret_length(length)
		puts "The length of the secret word is #{length}"
	end

	def pick_secret_word
		puts "Please choose a secret word. What is the length of your word?"
		gets.to_i
	end

	def guess(board)
		puts "guess a letter"
		gets.chomp.downcase
	end

	def check_guess(guess)
		puts %Q(Does your secret_word include "#{guess}"? yes or no)
		response = gets.chomp.downcase

		if response == "yes"
			matches = find_indices(guess)
		else
			matches = []
		end

	end

	def find_indices(guess)
		indices = []
		
		puts "At what spots can the guessed letter, '#{guess}', be found? Consider the first letter to be at position '1'. Seperate with commas."
		
		spots = gets.chomp.split(",")
		spots.map! { |spot| spot.to_i - 1} 
	end

	def handle_response(guess, matches)
		puts "You guessed #{guess}. There are #{matches.length} in the secret word."
		@used_letters << guess
		puts %Q(So far you have guessed the letters: #{@used_letters.join", "})
	end

	def get_word
		puts "What was your secret word?"
		gets.chomp
	end

end

class ComputerPlayer
	attr_reader :dictionary, :secret_word, :name

	def initialize(dictionary)
		@dictionary = dictionary
		@name = "Computer"
		@used_letters = []
	end

	def self.dictionary_from_file(file_name)
		ComputerPlayer.new(File.readlines(file_name).map(&:chomp))
	end

	def register_secret_length(length)
		@candidate_words = dictionary.select do |line|
			line.length == length
		end
	end

	def pick_secret_word
		@secret_word = dictionary.sample
		register_secret_length(secret_word.length)
		secret_word.length
	end

	def guess(board)
		letters_in_words = @candidate_words.join.chars
			
		board.each do |letter|
			letters_in_words.delete(letter) unless letter.nil?
		end
		@used_letters.each do |letter|
			letters_in_words.delete(letter)
		end
		get_mode(letters_in_words)
	end

	def get_mode(letters)
		count = Hash.new(0)
		letters.each { |letter| count[letter] += 1 }
		count.sort_by{|letter, value| value}.last[0]
	end

	def check_guess(guess)
		indices = []
		characters = secret_word.chars

		characters.each_with_index do |char, i|
			indices << i if char == guess
		end

		indices
	end

	def handle_response(guess, indices)
			@used_letters << guess
			@candidate_words.select! do |word|
			characters = word.chars
			other_indices = []
			
			characters.each_with_index do |char, i|
				other_indices << i if char == guess
			end
			
			other_indices == indices
		end
	end

	def candidate_words
		@candidate_words
	end

	def get_word
		@secret_word
	end

end

if __FILE__ == $PROGRAM_NAME

	puts "Hi. What's your name?"
	name = gets.chomp
	puts "Hi, #{name}! Would you like to be the guesser or the referee?"
		
		if gets.chomp.downcase == "guesser"
			guesser = HumanPlayer.new(name)
			referee = ComputerPlayer.dictionary_from_file("lib/dictionary.txt")
		else
			guesser = ComputerPlayer.dictionary_from_file("lib/dictionary.txt")
			referee = HumanPlayer.new(name)
		end

	game = Hangman.new({guesser: guesser, referee: referee})

	game.play

end
