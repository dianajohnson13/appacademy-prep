class RPNCalculator
  attr_reader :stack

  def initialize
  	@stack = []
  end

  def push(num)
  	stack << num
  end

  def plus
  	if stack.size < 2
  		raise "calculator is empty"
  	end
  	num1 = stack.pop
  	num2 = stack.pop
  	stack << num1 + num2
  end

  def minus
  	if stack.size < 2
  		raise "calculator is empty"
  	end
  	num1 = stack.pop
  	num2 = stack.pop
  	stack << num2 - num1
  end

  def divide
  	if stack.size < 2
  		raise "calculator is empty"
  	end
  	num1 = stack.pop
  	num2 = stack.pop
  	stack << num2 / num1.to_f
  end

  def times
  	if stack.size < 2
  		raise "calculator is empty"
  	end
  	num1 = stack.pop
  	num2 = stack.pop
  	stack << num2 * num1.to_f
  end

  def value
  	value = stack.pop
  	stack << value
  	value
  end

  def tokens(expression)
  	operations = %w(+ - / *)
    elements = expression.split

  	elements.map do |element|
  		operations.include?(element) ? element.to_sym : element.to_i
  	end

  end

  def evaluate(expression)
  	toks = tokens(expression)
  	
    toks.each do |token|
  		case
  		when token.is_a?(Integer)
  			stack.push(token)
  		when token == :+
  			plus
  		when token == :-
  			minus
  		when token == :/
  			divide
  		when token == :*
  			times
  		end
  	end
  	
    value
  end


end

if __FILE__ == $PROGRAM_NAME

  def run_test
    calc = RPNCalculator.new
    if ARGV.empty?
      test_manually(calc)
    else
      lines = File.readlines(ARGV[0])
      lines.each {|line| p calc.evaluate(line)}
    end
  end

  def test_manually(calc)
    puts "Please type each character of your expression on a new line and hit enter again when you are done."
    expression = ""
    input = " "
    until input == ""
      input = gets.chomp
      expression << input << " "
    end
    p calc.evaluate(expression)
  end

  run_test

end
