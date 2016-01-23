class ComputerPlayer
	attr_reader :name, :board, :mark

	def initialize(name)
		@name = name
		@board = Board.new
	end

	def mark=(mark)
		@mark = mark
	end

	def display(board)
		@board = board
	end

	def get_move
		open_spots = board.available_moves
		open_spots.each do |spot|
			test_board = board.dup
			test_board[*spot] = mark
			is_winner = test_board.winner
			test_board[*spot] = nil
			return spot if is_winner
		end
		open_spots.sample
	end

end
