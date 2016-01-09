def add(num1, num2)
    num1 + num2
end

def subtract(num1, num2)
    num1 - num2
end

def sum(numbers)
    sum = 0
    numbers.each {|num| sum += num}
    sum
end

def multiply(num1, num2)
   num1 * num2 
end

def power(number, exponent)
   number**exponent 
end

def factorial(number)
    return 1 if number == 0
    fact = 1
    while number > 0
        fact *= number
        number -= 1
    end
    fact
end