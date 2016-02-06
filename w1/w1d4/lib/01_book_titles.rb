class Book
	attr_reader :title
	
	LITTLE_WORDS = %w(a the and of over in an)

	def title=(title)
		words = title.split
		titlized_words = [words.first.capitalize]

		words[1..-1].each do |word|
			 if LITTLE_WORDS.include?(word)
			 	titlized_words << word
			 else
				titlized_words << word.capitalize 
			end
		end

		@title = titlized_words.join " "
	end
end
