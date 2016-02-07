# Options Hashes
#
# Write a method `transmogrify` that takes a `String`. This method should
# take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
# reasonable defaults in a `defaults` hash defined in the `transmogrify`
# method. Use `Hash#merge` to combine the defaults with any optional
# parameters passed by the user. Do not modify the incoming options
# hash. For example:
#
# ```ruby
# transmogrify("Hello")                                    #=> "Hello"
# transmogrify("Hello", :times => 3)                       #=> "HelloHelloHello"
# transmogrify("Hello", :upcase => true)                   #=> "HELLO"
# transmogrify("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# transmogrify("hello", options)
# # options shouldn't change.
# ```

def transmogrify(string, options = {})
	defaults = {times: 5, upcase: "false", reverse: "false"}
	options = defaults.merge(options)

	new_str = string

	new_str = new_str.upcase if options[:upcase] == true
	new_str = new_str.reverse if options[:reverse] == true

	extended_str = ""
	options[:times].times {extended_str << new_str}
	extended_str
end

transmogrify("Hello", {times: 4, upcase: true, reverse: true })
