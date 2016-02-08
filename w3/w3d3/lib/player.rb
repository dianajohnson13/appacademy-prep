class HumanPlayer

	attr_reader :name

	def initialize(name)
		@name = name
	end

	def get_play
		puts "Where would you like to attack? Please respond like so: row,column"
		move = input_to_array
		p move
	end

	def input_to_array
		input = gets.chomp.split(",")
		output = input.map {|x| x.to_i }
	end

end
