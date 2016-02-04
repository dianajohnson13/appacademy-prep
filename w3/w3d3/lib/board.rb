class Board
	attr_accessor :grid, :number_ships

	def initialize(grid = Board.default_grid)
		@grid = grid
		@number_ships = 20
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

	def populate_grid
		number_ships.times {place_random_ship}
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
		return true if (pos[0] < 10) && (pos[1] < 10)
		false
	end

end