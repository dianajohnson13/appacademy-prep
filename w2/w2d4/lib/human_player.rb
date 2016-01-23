class HumanPlayer
	attr_reader :name, :mark

	def initialize(name)
		@name = name
	end

	def mark=(mark)
		@mark = mark
	end

	def get_move
		puts "where would you like to play your turn?"
		response = gets.chomp
		p response
		move = response.split(", ").map {|x| x.to_i}
	end

	def display(board)
		board.grid.each {|row| p row}
	end
end