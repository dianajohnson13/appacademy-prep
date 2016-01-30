class Ship
	attr_reader :board, :model

		SHIPS_LENGTH = { 
		"aircraft carrier" => 5, 
		"battleship" => 4, 
		"submarine" => 3, 
		"destroyer" => 3, 
		"patrol boat" => 2 }

	def initialize(board, model = Ship.random)
		@board = board
		@model = model
		@length = SHIPS_LENGTH[model]
	end

	def self.random
		SHIPS_LENGTH.keys.sample
	end

	def spots_available?(required_spots)
		required_spots.each do |spot|
			if board[spot] == :s || board.in_range?(spot) == false
				return false
			end
		end
		true
	end

	def spots_required(first_spot)
		row = first_spot[0]
		col = first_spot[1]
		required_spots = []

		SHIPS_LENGTH[model].times do |x|
			required_spots << [row, col + x]
		end

		required_spots
	end

	def place_ship(required_spots)
		required_spots.each do |spot|
			board[*spot] = :s
		end
	end

end