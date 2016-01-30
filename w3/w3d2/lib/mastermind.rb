class Code
  attr_reader :pegs

  def initialize(pegs)
  	@pegs = pegs
  end

  PEGS = {
  	r: "red",
  	b: "blue",
  	g: "green",
  	y: "yellow",
  	o: "orange",
  	p: "purple"
  }

  def self.random
  	selection = []
  	4.times {selection << PEGS.keys.sample.to_s}
  	self.new(selection)
  end

  def self.parse(code)
  	colors = code.downcase.chars
  	colors.each { |color| raise "Error" unless PEGS.keys.include?(color.to_sym) }
  	self.new(colors)
  end

  def [](peg)
  	pegs[peg]
  end

  def exact_matches(code)
  	matches = 0
  	pegs.each_index { |i| matches += 1 if code[i] == pegs[i] }
  	matches
  end

  def near_matches(code)
  	pegs_hash = self.pegs_hash
  	code_hash = code.pegs_hash
  	matches = 0

    code_hash.keys.each do |peg|
      if pegs_hash.keys.include?(peg)
      	matches += [code_hash[peg], pegs_hash[peg]].min
      end
    end

    matches - self.exact_matches(code)
	end

  def pegs_hash
  	hash = Hash.new(0)
  	pegs.each {|peg| hash[peg] += 1 }
  	hash
  end

  def ==(code)
  	return true if code.is_a?(Code) && pegs.join == code.pegs.join
  	false
  end

end

class Game
  attr_reader :secret_code

  def initialize(secret_code = Code.random)
  	@secret_code = secret_code
  end

  def get_guess
    puts "Please make a guess. So far you have made #{count} of 10 guesses."
  	guess = $stdin.gets.chomp
  	p guess
  	Code.parse(guess)
  end

  def display_matches(code)
  	p "exact: #{secret_code.exact_matches(code)}"
  	p "near: #{secret_code.near_matches(code)}"
  end

  def play
  	puts "Let's play Mastermind!"
  	10.times do |count|
	  	guess = get_guess
	  	display_matches(guess)
	  	return puts "You win!!" if guess.pegs == secret_code.pegs
	  end
		
		puts "You lose!! The answer was #{secret_code.pegs}"
  end

end

if __FILE__ == $PROGRAM_NAME
	new_game = Game.new
	new_game.play
end

