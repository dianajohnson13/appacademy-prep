class HumanPlayer
	attr_reader :name, :mark

	def initialize(name)
		@name = name
	end

	def mark=(mark)
		@mark = mark
	end

	def get_move
		puts "where would you like to play your turn? row,col"
		response = gets.chomp.split(",")
		response.map(&:to_i)
	end

	def display(board)
		board.grid.each {|row| p row}
	end
end