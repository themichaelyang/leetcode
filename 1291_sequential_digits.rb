# An integer has sequential digits if and only if each digit in the number is one more than the previous digit.
# Return a sorted list of all the integers in the range [low, high] inclusive that have sequential digits.

def sequential_digits(low, high)
  low_digits = Math.log(low, 10).round
  high_digits = Math.log(high, 10).round

  sequentials = []
  (low_digits..(high_digits + 1)).each do |digits|
    seq = (1..digits).to_a.join.to_i
    step = ('1' * digits).to_i
  
    while seq % 10 != 0
      if seq >= low and seq <= high
        sequentials << seq
      end
      seq += step
    end
  end

  sequentials
end


require_relative './test'
extend TestSuite

assert_equals(sequential_digits(10, 30), [12, 23])
assert_equals(sequential_digits(100, 300), [123, 234])