class Board
	attr_accessor :grid

	@@spots_taken = 0

	def initialize(grid = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
		@grid = grid
	end

	def grid
		@grid
	end

	def [](row, col)
		@grid[row][col]
	end

	def []=(row, col, mark)
		@grid[row][col] = mark
	end

	def place_mark(pos, mark)
		grid.each {|row| p row}
		if self.empty?(pos)
			self[*pos] = mark
		else
			raise "That spot is already taken!"
		end
	end

	def empty?(pos)
		return true if self[*pos].nil?
		false
	end

	def over?
		return true if !(grid.flatten.include?(nil))
		return true if winner == :X || winner == :O
		false
	end

	def winner
		grid.each do |row|
			return row[0] if row.all? { |el| el == row[0] }
		end

		sub_arrs = grid.count
		0.upto(sub_arrs - 1) do |col|
			in_a_row = 0
			0.upto(sub_arrs - 1) do |row|
				unless (grid[row][col]).nil?
					in_a_row += 1 if grid[row][col] == grid[0][col]
				end
				return grid[0][col] if in_a_row == sub_arrs
			end
		end

		return grid[0][0] if diagonial_down_winner?
		return grid[0][sub_arrs - 1] if diagonial_up_winner?
		
		return nil
	end

	def diagonial_down_winner?
		sub_arrs = grid.count
		(0...sub_arrs).each do |i|
			return false if grid[i][i] != grid[0][0]
		end
		true
	end

	def diagonial_up_winner?
		sub_arrs = grid.count
		i = 0
		j = sub_arrs - 1
		while i < sub_arrs
			return false if grid[i][j] != grid[0][sub_arrs - 1]
			i += 1
			j -= 1
		end
		true
	end

	def available_moves
		open_spots = []

		(0..2).each do |row|
			(0..2).each do |col|
				open_spots << [col, row] if (grid[col][row]).nil?
			end
		end
		open_spots
	end

end