require_relative 'board'
require_relative 'player'
require_relative 'ship'

class BattleshipGame

  def initialize(player1, player2 = nil)
  	@player1 = player1
    @player2 = player2
    @curr_player = player1
    @opponent = player2
    @ship_quantity = 3
  end

  def curr_player
    @curr_player
  end

  def opponent
    @opponent
  end

  def switch_players!
    if curr_player == @player1
      @curr_player = @player2
      @opponent = @player1
    else
      @curr_player = @player1
      @opponent = @player2
    end
  end

  def play
    @player1.setup_board(@ship_quantity)
    @player2.setup_board(@ship_quantity)

    until game_over?
      play_turn
      @opponent.board.display
      switch_players!
    end
  end

  def play_turn
    players_move = @curr_player.get_play
    if @opponent.board.in_range?(players_move)
      attack(players_move)
    else
      puts "That's not a valid move!"
    end
  end

  def attack(pos)
    if @opponent.board[pos] == :s
      puts "#{@curr_player.name} Hits!"
      @opponent.board[*pos] = :x
    else 
      puts "#{@curr_player.name} Misses!"
      @opponent.board[*pos] = :m
    end
  end

  def game_over?
    @curr_player.board.won?
  end

end

if __FILE__ == $PROGRAM_NAME

  player1 = HumanPlayer.new("Chris")
  player2 = ComputerPlayer.new("Bob")
  game = BattleshipGame.new(player1, player2)

  game.play

end