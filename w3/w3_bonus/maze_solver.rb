class Maze
	attr_reader :board, :prev_pos, :queue, :parent

	def initialize(board)
		@board = board
		@prev_pos = []
		@queue = []
		@parent = Hash.new(nil)
	end

	def self.maze_from_file(file_name)
		Maze.new(File.readlines(file_name).map{|line| line.chomp.chars})
	end

	def find_start
		board.each_with_index do |row, i|
			row.each_index { |j| return [i, j] if self[i, j] == "S" }
		end
	end

	def move(pos)
		@queue << pos
		@prev_pos << pos

		until @queue.empty?
			# sleep(1)
			top = @queue.shift
			return top if self[*top] == "E" #returns pos of "E"
			find_row(top)
		end
	end


	def find_row(pos)
		
		left = [pos[0], pos[1] - 1]
		right = [pos[0], pos[1] + 1]
		up = [pos[0] - 1, pos[1]]
		down = [pos[0] + 1, pos[1]]

		potential_pos = [left, right, up, down]

		potential_pos.each do |pot_pos|
			unless self[*pot_pos] == "*" || @prev_pos.include?(pot_pos)
				@prev_pos << pot_pos
				@parent[pot_pos] = pos
				@queue << pot_pos
			end
		end
	end

	def backtrack(pos)
		pos = @parent[pos] # Skip over E so I don't overwrite it.
		until @parent[pos].nil?
			self[*pos] = "X"
			pos = @parent[pos]
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
		@parent[start_pos] = nil
		end_location = move(start_pos)
		backtrack(end_location)
		
		display_board
		return board
	end

	def display_board
		board.each { |row| puts row.join }
	end

end


if __FILE__ == $PROGRAM_NAME

maze_solver = Maze.maze_from_file(ARGV[0])

solved_maze = File.open("solution.txt", "w")

solution = maze_solver.run_maze

solution.each {|line| solved_maze.puts line.join}

solved_maze.close()

end