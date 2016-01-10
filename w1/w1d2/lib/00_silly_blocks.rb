def reverser(&proc)
	words = proc.call
	words.split.map { |word| word.reverse }.join " "
end

def adder(additional = 1)
	yield + additional
end

def repeater(times = 1, &proc)
	times.times {proc.call}
end