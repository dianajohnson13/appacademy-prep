ALPHABET = ("a"..."z")
VOWELS = %(a e i o u)

def translate(statement)
  words = statement.split
  piggified_words = words.map { |word| translate_word(word) }
  piggified_words.join " "
end

def translate_word(word)
  letters = word.downcase.chars

  if ALPHABET.include?(letters.last)
    new_word = swap_letters(letters).join
  else
    punctuation = letters.pop
    new_word = (swap_letters(letters) << punctuation).join
  end

  is_capped?(word) ? new_word.capitalize : new_word
end

def swap_letters(letters)
  until VOWELS.include?(letters[0])
    if letters[0..1] == ["q", "u"]
      letters.push(letters[0..1]).shift(2)
    else 
     letters.push(letters[0]).shift
    end
  end
  letters << "ay"
end

def is_capped?(word)
 word.capitalize == word
end