=begin
Each new term in the Fibonacci sequence is generated
by adding the previous two terms. By starting with 1 and 2,
the first 10 terms will be 1, 2, 3, 5, 8, 13, 21, 34, 55, 89,..
By considering terms in the Fibonacci sequence whose values do 
not exceed four million, find the sum of the even-valued terms.
=end

def num_even?(num)
  num % 2 == 0 ? true : false
end

num1 = 1
num2 = 2
all_nums = [num2]
while (num1 + num2) < 4000000
    sum_of_nums = num1 + num2
    num1 = num2
    num2 = sum_of_nums
    all_nums << num2
end

even_nums = all_nums.select {|num| num_even?(num)}

sum_of_evens = 0
even_nums.each do |next_num|
  sum_of_evens += next_num
end

puts sum_of_evens

# Answer = 4613732