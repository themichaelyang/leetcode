# Given a positive integer n, write a function that returns the number of set bits in its binary representation (also known as the Hamming weight).
# Follow up: If this function is called many times, how would you optimize it?

# @param {Integer} n
# @return {Integer}
def hamming_weight(n)
  ones = 0

  while n > 0
    ones += 1 if n % 2 == 1
    n = n >> 1
  end

  ones
end

# # @param {Integer} n
# # @return {Integer}
# def hamming_weight(n)
#   ones = 0

#   while n > 0
#     ones += case n % 8
#       when 0b000 then 0
#       when 0b001, 0b010, 0b100 then 1
#       when 0b011, 0b101, 0b110 then 2
#       when 0b111 then 3
#     end
#     n = n >> 3
#   end

#   ones
# end

require_relative './testing'
Testing.expect(hamming_weight(0), 0)
Testing.expect(hamming_weight(1), 1)
Testing.expect(hamming_weight(2), 1)
Testing.expect(hamming_weight(3), 2)
Testing.expect(hamming_weight(4), 1)
Testing.expect(hamming_weight(0b1010101), 4)
Testing.expect(hamming_weight(128), 1)
Testing.expect(hamming_weight(2147483645), 30)
Testing.summary
