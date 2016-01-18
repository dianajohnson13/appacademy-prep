# The prime factors of 13195 are 5, 7, 13, and 29.
# What is the largest prime factor of the number 600851475143 ?


num = 600851475143
factor = 2
until factor == num
  if num % factor == 0
    num = num / factor
    factor = 2
  else
    factor += 1
  end
end
puts num

# Answer = 6857