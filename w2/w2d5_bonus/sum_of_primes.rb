def is_prime?(num)
	(2...num).each {|factor| return false if num % factor == 0}
	true
end

def sum_of_primes
	prime_count = 0
	sum_of_primes = 0
	num = 2
	until prime_count == 1000
		if is_prime?(num)
			prime_count += 1
			sum_of_primes += num
		end
		num += 1
	end
	sum_of_primes
end

p sum_of_primes