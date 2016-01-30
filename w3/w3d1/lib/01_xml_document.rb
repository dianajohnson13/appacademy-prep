class XmlDocument
	attr_reader :indent
	attr_accessor :indent_spaces

	def initialize(indent = false)
		@indent = indent
		@indent_spaces = 0
	end

  def method_missing(method, *args, &proc)
  	tag_name = method.to_s
  	xml = "<#{tag_name}"
  	
  	if args.first.is_a?(Hash)
  		args.first.each do |key, value|
  			xml << %Q( #{key.to_s}=\"#{value}\")
  		end
  	end

  	if block_given?
  		add_indent
  		xml << ">#{newline}#{indentation}#{proc.call}"
  		unindent
  		xml << "#{indentation}</#{tag_name}>#{newline}"
  	else
  		xml << "/>#{newline}"
  	end
  	
  	xml
  end

  def newline
  	return "\n" if indent
  	return "" 
  end

  def indentation
  	spacing = "" 
  	spacing << ("  " * indent_spaces) if indent
  	spacing
  end

  def add_indent()
  	@indent_spaces += 1
  end

  def unindent()
		@indent_spaces -= 1
  end

end
