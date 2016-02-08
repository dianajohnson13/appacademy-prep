class HumanPlayer
	attr_accessor :name, :board

	def initialize(name, board = Board.new)
		@name = name
		@board = board
	end

	def input_to_array
		input = gets.chomp.split(",")
		output = input.map {|x| x.to_i }
	end


	def get_play
		puts "#{name}, where would you like to attack? Please respond like so: row,column"
		move = input_to_array
		p move
	end

	def setup_board(ship_quantity)
		ship_options = ["aircraft carrier", "battleship", "submarine", "destroyer", "patrol boat"]
		ship_quantity.times do
			
			puts "#{name}, what ship would you like to add? Your options are: #{ship_options.join(", ")}"
			ship = Ship.new(board, gets.chomp)
			
			placed = false
			until placed == true
				puts "#{name}, where would you like to put this ship? Please type the designation (row,column) of the first spot your ship will take up."
				first_spot = input_to_array

				required_spots = ship.spots_required(first_spot)
				if ship.spots_available?(required_spots)
					ship.place_ship(required_spots)
					board.display_for_player
					placed = true
				else
					puts "You can't put a ship there!"
				end
			end
		end
	end

end

class ComputerPlayer

	attr_accessor :name, :board

	def initialize(name, board = Board.new)
		@name = name
		@board = board
	end

	def input_to_array
		input = gets.chomp.split(",")
		output = input.map {|x| x.to_i }
	end

	def get_play
		move = board.available_spots.sample
	end

	def setup_board(ship_quantity)
		ship_quantity.times do
			ship = Ship.new(board)
			placed = false

			until placed == true
				first_spot = board.available_spots.sample
				required_spots = ship.spots_required(first_spot)
				
				if ship.spots_available?(required_spots)
					ship.place_ship(required_spots)
					placed = true
				end
			end

		end
	end

end
