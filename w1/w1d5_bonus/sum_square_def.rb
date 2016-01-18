# Find the difference between the sum of the squares of the first 
# one hundred natural numbers and the square of the sum.


sum_of_num = (1..100).inject(0) { |sum, num| sum += num }
sum_of_nums_squared = sum_of_num**2

sum_of_squares = (1..100).inject(0) { |sum, num| sum += num**2 }

difference = sum_of_nums_squared - sum_of_squares
puts difference

# Answer = 25164150