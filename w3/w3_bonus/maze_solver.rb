class Maze
	attr_accessor :board, :prev_pos, :count, :queue

	def initialize(board)
		@board = board
		@prev_pos = []
		@count = 0
		@queue = []
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
		
		@queue << pos
		@prev_pos << pos

			p queue
			until queue.empty?
				# sleep(1)
				top = @queue.shift
				return true if self[*top] == "E"
				self[*top] = count
				find_row(top)
			end
	end


	def find_row(pos)
		@count += 1
		
		left = [pos[0], pos[1] - 1]
		right = [pos[0], pos[1] + 1]
		up = [pos[0] - 1, pos[1]]
		down = [pos[0] + 1, pos[1]]

		potential_pos = [left, right, up, down]

		potential_pos.each do |pot_pos|
			unless self[*pot_pos] == "*" || @prev_pos.include?(pot_pos)
				@prev_pos << pot_pos
				@queue << pot_pos
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
			p row
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