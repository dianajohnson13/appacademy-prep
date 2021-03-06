class Temperature

  def initialize(temp)
  	temp.has_key?(:f) ? @temp = temp[:f] : @temp = self.class.ctof(temp[:c])
  end

  def celsius=(cel)
  	@temp = self.class.ctof(cel)
  end

  def fahrenheit=(far)
  	@temp = far
  end

  def in_celsius
  	self.class.ftoc(@temp)
  end

  def in_fahrenheit
  	@temp
  end

  def self.from_celsius(celsius) 
  	self.new(:c => celsius)
  end

  def self.from_fahrenheit(fahrenheit) 
  	self.new(:f => fahrenheit)
  end

  def self.ctof(temp)
  	 (temp * (9 / 5.0)) + 32
  end

  def self.ftoc(temp)
  	 (temp - 32) * (5 / 9.0)
  end

end

class Celsius < Temperature
	def initialize(temp)
		self.celsius = temp
	end
end

class Fahrenheit < Temperature
	def initialize(temp)
		self.fahrenheit = temp
	end
end