def translate(statement)
  words = statement.split
  piggified_words = words.map {|word| translate_word(word)}
  piggified_words.join " "
end

def translate_word(word)
  vowels = %(a e i o u)
  letters = word.chars

  until vowels.include?(letters[0])
    if letters[0..1] == ["q", "u"]
      letters.push(letters[0..1]).shift(2) 
    else 
     letters.push(letters[0]).shift
    end
  end
  
  (letters << "ay").join
end