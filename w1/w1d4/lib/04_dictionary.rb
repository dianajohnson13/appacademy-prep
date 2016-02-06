class Dictionary
	attr_reader :entries

	def initialize
		@entries = {}
	end

	def add(entry)
		if entry.is_a?(Hash)
			entries.merge!(entry)
		elsif entry.is_a?(String)
			entries[entry] = nil
		end
	end

	def keywords
		self.entries.keys.sort {|key1, key2| key1 <=> key2}
	end

	def include?(key)
		entries.key?(key)
	end

	def find(str)
		entries.select {|key| key.start_with?(str)}
	end

	def printable
		sorted_and_printable = self.keywords.map do |key| 
			%Q([#{key}] "#{entries[key]}")
		end

		sorted_and_printable.join ("\n")
	end

end
