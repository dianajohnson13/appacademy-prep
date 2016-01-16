class RPNCalculator
  attr_accessor :stack

  OPERATIONS = [:+, :-]

  def initialize
  	@stack = []
  end

  def push(num)
  	stack << num
  end

  def plus
  	sum = stack[0] + stack[1]
  end

  def value
   stack.plus
  end

end