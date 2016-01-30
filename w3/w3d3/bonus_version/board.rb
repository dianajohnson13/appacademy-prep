class Board
	attr_accessor :grid

	def initialize(grid = Board.default_grid)
		@grid = grid
	end

	def self.default_grid
		(Array.new(10) {Array.new(10, nil)})
	end

	def display
		display_board = []
		
		grid.each do |row|
			display_row = []

			row.each do |spot|
				case spot
				when :x
					display_row << :x
				when :m
					display_row << :m
				else
					display_row << :_
				end
			end

			display_board << display_row
		end
		display_board.each { |row| p row }
	end

	def display_for_player
		display_board = []

		grid.each do |row|
			display_row = []

			row.each do |spot|
				if spot == :s
					display_row << :s
				else
					display_row << :_
				end
			end

			display_board << display_row
		end

		display_board.each { |row| p row }
	end

	def count
		remaining_ships = 0
		grid.each do |row|
			row.each { |spot| remaining_ships += 1 if spot == :s }
		end
		remaining_ships
	end

	def empty?(pos = "blank")
		if pos == "blank"
			grid.each do |row|
				return false if row.include?(:s)
			end
			return true
		end
		self[pos].nil?
	end

	def full?
		grid.each do |row| 
			row.each { |spot| return false if spot.nil? }
		end
		true
	end

	def place_random_ship
		if self.full?
			raise "Board is full"
		else
			rand_pos = self.available_spots.sample
			p rand_pos
			self[*rand_pos] = :s
		end
	end

	def won?
		grid.each do |row|
			row.each { |spot| return false if spot == :s }
		end
		true
	end

	def available_spots
		empty_spaces = []
		grid.each_with_index do |row, i|
			row.each_index { |j| empty_spaces << [i, j] }
		end
		empty_spaces
	end

	def [](pos)
		x, y = pos
		@grid[x][y]
	end

	def []=(row, col, mark)
		@grid[row][col] = mark
	end

	def in_range?(pos)
		if (pos[0] < 10) && (pos[1] < 10)
			return true
		end
		false
	end

end

if __FILE__ == $PROGRAM_NAME
	test_board = Board.new

	test_board.display
end
