file = File.open(ARGV[0])
file.readlines.each do |line|
	unless line.empty?
		line_array = line.strip.split(",")
		puts line_array.uniq.join(",")
	end
end