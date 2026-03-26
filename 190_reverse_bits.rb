# Reverse bits of a given 32 bits signed integer.

# The test cases are a bit confusing
# but it's expecting us to just reverse the bits.
#
# The integer interpretation of these bits could change depending on
# the representation. In Ruby, this yields an unsigned integer and
# not twos-complement.

# @param {Integer} n
# @return {Integer}
def reverse_bits(n)
  out = 0

  0.upto(31).each do |i|
    lsb = n >> i & 0b1
    out |= lsb << 31 - i
  end

  out
end

require_relative './testing'
Testing.expect(reverse_bits(43261596), 964176192)
Testing.expect(reverse_bits(2147483644), 1073741822)
Testing.summary
