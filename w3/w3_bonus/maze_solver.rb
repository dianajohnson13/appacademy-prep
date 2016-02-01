class Maze
	attr_accessor :board

	def initialize(board)
		@board = board
		@count = 0
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

	def move(pos, prev_pos)
		puts "skafjlksj" if self[*pos] == "E"
		if self[*pos] == " "
			self[*pos] = "#{@count}"
			@count += 1
		end
		display_board
		p " "

		left = [pos[0], pos[1] - 1]
		right = [pos[0], pos[1] + 1]
		up = [pos[0] - 1, pos[1]]
		down = [pos[0] + 1, pos[1]]

		move(left, pos) if self[*left] == " " && left != prev_pos
		move(up, pos) if self[*up] == " " && up != prev_pos
		move(right, pos) if self[*right] == " " && right != prev_pos
		move(down, pos) if self[*down] == " " && down != prev_pos

	end

	def [](row, col)
		@board[row][col]
	end

	def []=(row, col, mark)
		@board[row][col] = mark
	end

	def run_maze
		start_pos = find_start
		move(start_pos, start_pos)
		return board
	end

	def display_board
		board.each do |row|
			#puts row.join
			p row
		end
	end

end


if __FILE__ == $PROGRAM_NAME

maze_solver = Maze.maze_from_file(ARGV[0])

# solved_maze = File.open("solution.txt", "w")
# solved_maze.puts 

maze_solver.run_maze

# solved_maze.close()

end