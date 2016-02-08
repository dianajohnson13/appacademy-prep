require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
	attr_accessor :board, :player_one, :player_two, :current_player

	def initialize(player_one, player_two)
		@board = Board.new
		@player_one = player_one
		@player_two = player_two
		@current_player = player_one
	end

	def play_turn
		move = current_player.get_move
		board.place_mark(move, current_player.mark)
		switch_players!
	end

	def current_player
		@current_player
	end

	def switch_players!
		if current_player == player_one
			@current_player = player_two
		else
			@current_player = player_one
		end
	end

	def play
		game_over = false
		until game_over == true
			@current_player.display(board)
			play_turn
			game_over = true if board.over?
		end
		p board.winner
	end

	
end

if __FILE__ == $PROGRAM_NAME
	
	player_one = HumanPlayer.new("Bob")
	player_two = ComputerPlayer.new("John")

	player_one.mark = :X
	player_two.mark = :O

	test_game = Game.new(player_one, player_two)

	test_game.play

end

