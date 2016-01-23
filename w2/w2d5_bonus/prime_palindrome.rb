def is_palindrome?(num)
	digits = num.to_s
	return true if digits == digits.reverse
	false
end

def is_prime?(num)
	(2...num).each {|factor| return false if num % factor == 0}
	true
end

def prime_palindrome
	current_largest = 0  #largest prime palindrome under 1000
	(0..1000).each do |num|
		current_largest = num if is_palindrome?(num) && is_prime?(num)
	end
	current_largest
end


p prime_palindrome