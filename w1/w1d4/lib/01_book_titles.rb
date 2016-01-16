class Book
	attr_reader :title
	
	LITTLE_WORDS = %w(a the and of over in an)

	def title=(title)
		words = title.split
		cap_words = [words.first.capitalize]

		words[1..-1].each do |word|
			 if LITTLE_WORDS.include?(word)
			 	cap_words << word
			 else
				cap_words << word.capitalize 
			end
		end

		@title = cap_words.join " "
	end
end
