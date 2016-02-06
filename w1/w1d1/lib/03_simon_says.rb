def echo(statement)
    statement
end

def shout(statement)
    statement.upcase
end

def repeat(statement, times = 2)
    words = Array.new(times, statement)
    words.join " "
end

def start_of_word(word, number_of_letters)
    word[0, number_of_letters]
end

def first_word(statement)
   words = statement.split
   words[0]
end

def titleize(title)
    small_words = ["the", "over", "and"]
    words = title.split

    words.each_with_index do |word, index| 
       word.capitalize! unless (index > 0) && (small_words.include?(word))
    end
    
    words.join " "
end
