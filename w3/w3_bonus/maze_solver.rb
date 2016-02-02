class Maze
	attr_accessor :board, :prev_pos

	def initialize(board)
		@board = board
		@prev_pos = []
	end

	def self.maze_from_file(file_name)
		Maze.new(File.readlines(file_name).map{|line| line.chomp.chars})
	end

	def find_start
		board.each_with_index do |row, i|
			row.each_index do |j|
				return [i, j] if self[i, j] == "S"
			end
		end
	end

	def move(pos)

		if self[*pos] == "E"
			puts "FOUND THE END!!!!!!!!!!!"
			return true
		end

		@prev_pos << pos

		self[*pos] = "M"  #previous pos array?

		left = [pos[0], pos[1] - 1]
		right = [pos[0], pos[1] + 1]
		up = [pos[0] - 1, pos[1]]
		down = [pos[0] + 1, pos[1]]

		# move(left, pos) if (self[*left] == " " || self[*left] == "E") && left != prev_pos
		# move(up, pos) if (self[*up] == " " || self[*up] == "E") && up != prev_pos
		# move(right, pos) if (self[*right] == " " || self[*right] == "E") && right != prev_pos
		# move(down, pos) if (self[*down] == " " || self[*down] == "E") && down != prev_pos

		unless self[*left] == "*" || prev_pos.include?(left)
			if move(left) == true
				self[*pos] = "X"
				p pos 
				return true
			end
		end
		unless self[*up] == "*" || prev_pos.include?(up)
			if move(up) == true
				self[*pos] = "X" 
				p pos
				return true
			end 
		end
		unless self[*right] == "*" || prev_pos.include?(right)
			if move(right) == true
				self[*pos] = "X"
				p pos 
				return true
			end 
		end
		unless self[*down] == "*" || prev_pos.include?(down)
			if move(down) == true
				self[*pos] = "X"
				p pos
				return true
			end 
		end

	end

	def [](row, col)
		@board[row][col]
	end

	def []=(row, col, mark)
		@board[row][col] = mark
	end

	def run_maze
		start_pos = find_start
		move(start_pos)
		display_board
		return board
	end

	def display_board
		board.each do |row|
			puts row.join
		end
	end

end


if __FILE__ == $PROGRAM_NAME

maze_solver = Maze.maze_from_file(ARGV[0])

solved_maze = File.open("solution.txt", "w")

solution = maze_solver.run_maze

solution.each {|line| solved_maze.puts line.join}

solved_maze.close()

end