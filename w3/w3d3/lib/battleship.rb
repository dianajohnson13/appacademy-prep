require_relative 'board'
require_relative 'player'
require_relative 'ship'

class BattleshipGame
  attr_reader :player1, :player2, :curr_player, :opponent, :ship_quantity

  def initialize(player1, player2 = nil)
  	@player1 = player1
    @player2 = player2
    @curr_player = player1
    @opponent = player2
    @ship_quantity = 2
  end

  def curr_player
    @curr_player
  end

  def opponent
    @opponent
  end

  def switch_players!
    if curr_player == player1
      @curr_player = player2
      @opponent = player1
    else
      @curr_player = player1
      @opponent = player2
    end
  end

  def play
    player1.setup_board(ship_quantity)
    player2.setup_board(ship_quantity)

    until game_over?
      play_turn
      opponent.board.display
      switch_players!
    end
  end

  def play_turn
    players_move = curr_player.get_play
    attack(players_move)
  end

  def attack(pos)
    if opponent.board[pos] == :s
      puts "#{curr_player.name} Hits!"
      opponent.board[*pos] = :x
    else 
      puts "#{curr_player.name} Misses!"
      opponent.board[*pos] = :m
    end
  end

  def count
    board.count
  end

  def game_over?
    return true if curr_player.board.won?
    false
  end


end

if __FILE__ == $PROGRAM_NAME

  player1 = HumanPlayer.new("Chris")
  player2 = ComputerPlayer.new("Bob")
  game = BattleshipGame.new(player1, player2)

  game.play

end