#Find the sum of the multiples of 3 or 5 below 1000.

sum = 0
(1...1000).each do |num|
  if (num % 3 == 0) || (num % 5 == 0)
    sum += num
  end
end
puts sum

# Answer = 233168