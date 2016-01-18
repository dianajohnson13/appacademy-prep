# A palindrome number reads the same both ways. The largest palindrome
# made from the product of two 2-digit numbers is 9009 = 91 x 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

def is_palindrome?(num)
  characters = num.to_s
  return true if characters == characters.reverse
  false
end

def div_by_two_three_digits?(num)
  (100..999).each do |div|
    return true if (num % div == 0) && ((num / div).between?(100, 999))
  end
  false
end

num = 999 * 999
while num > 0
  if is_palindrome?(num) && div_by_two_three_digits?(num)
    puts num
    break
  end
  num -= 1
end


# Answer = 906609