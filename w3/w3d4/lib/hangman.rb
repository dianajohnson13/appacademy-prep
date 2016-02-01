class Hangman
	attr_reader :guesser, :referee, :board, :players

	def initialize(players = {guesser: guesser, referee: referee})
		@players = players
	end

	def guesser
		@guesser = players[:guesser]
	end

	def referee
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
		p display_board
	end

	def play
		puts "Let's play Hangman!"
		puts "#{guesser.name} will guess the word, and #{referee.name} will be the referee."
		setup

		10.times do |guess|
			if board.include?(nil)
				display_board
				take_turn
			else
				puts "#{guesser.name} wins!! The word was #{referee.secret_word}"
				return
			end
			puts "#{guess + 1} guesses out of 10 have been made."
		end

		puts "#{guesser.name} looses! The word was #{referee.secret_word}"
	end

	# def valid_word?(secret_word)
	# 	secret_word = referee.secret_word
	# 	if guesser.is_a?(ComputerPlayer)
	# 		if !(guesser.dictionary.include?(secret_word))
	# 			raise "That is not a word in the dictionary!"
	# 		end
	# 	end
	# 	true
	# end

end

class HumanPlayer
	attr_accessor :secret_word, :name, :used_letters

	def initialize(name)
		@name = name
		@used_letters = []
	end
	
	def register_secret_length(length)
		puts "The length of the secret word is #{length}"
	end

	def pick_secret_word
		puts "Please type a secret word."
		@secret_word = gets.chomp
		secret_word.length
	end

	def guess(board)
		puts "guess a letter"
		gets.chomp.downcase
	end

	def check_guess(guess)
		puts %Q(Does your secret_word include "#{guess}"? Yes or No)
		response = gets.chomp.downcase

		if response == "no" && secret_word.include?(guess)
			puts "Lier!! Let's try that again..."
			check_guess(guess)
		elsif response == "no"
			return []
		elsif response == "yes" && !(secret_word.include?(guess))
			puts "No it doesn't! Did you forget your secret word?"
			find_indices(guess)
		else
			find_indices(guess)
		end

	end

	def find_indices(guess)
		indices = []
		characters = secret_word.chars

		characters.each_with_index do |char, i|
			indices << i if char == guess
		end

		indices
	end

	def handle_response(guess, matches)
		puts "You guessed #{guess}. There are #{matches.length} in the secret word."
		used_letters << guess
		puts %Q(So far you have guessed the letters: #{used_letters.join", "})
	end

end

class ComputerPlayer
	attr_reader :dictionary, :secret_word, :candidate_words, :used_letters, :name

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
		letters_in_words = candidate_words.join.chars
			
		board.each do |letter|
			letters_in_words.delete(letter) unless letter.nil?
		end
		used_letters.each do |letter|
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

end

if __FILE__ == $PROGRAM_NAME

	puts "Hi. What's your name?"
	name = gets.chomp
	puts "Would you like to be the guesser or the referee?"
		
		if gets.chomp.downcase == "guesser"
			guesser = HumanPlayer.new(name)
			referee = ComputerPlayer.dictionary_from_file("lib/dictionary.txt")
		else
			guesser = ComputerPlayer.dictionary_from_file("lib/dictionary.txt")
			referee = HumanPlayer.new(name)
		end

	game = Hangman.new(players = {guesser: guesser, referee: referee})

	game.play

end
