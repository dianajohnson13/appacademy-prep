
def reverse_words
	lines = File.readlines(ARGV[0])
	new_file = File.open("new_file.txt", "w")
	lines.each do |line|
		new_file.puts (line.split.reverse.join " ")
	end
	new_file.close
	File.open("new_file.txt", "r")  {|file| puts file.read}
end

reverse_words