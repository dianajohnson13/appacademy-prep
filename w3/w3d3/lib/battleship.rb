require_relative 'board'
require_relative 'player'

class BattleshipGame
  attr_reader :player, :board

  def initialize(player, board = Board.new)
  	@player = player
    @board = board
  end

  def play
    board.populate_grid
    until game_over?
      play_turn
      board.display
    end
    puts "You win!"
  end

  def play_turn
    move = player.get_play
    if board.in_range?(move)
      attack(move)
    else
      puts "That's not a valid move!"
    end
  end

  def attack(pos)
    if board[pos] == :s
      puts "Hit!"
    else 
      puts "Miss!"
    end
    board[*pos] = :x
  end

  def count
    board.count
  end

  def game_over?
    return true if board.won?
    false
  end


end

if __FILE__ == $PROGRAM_NAME

  player = HumanPlayer.new("Chris")
  game = BattleshipGame.new(player)

  game.play

end