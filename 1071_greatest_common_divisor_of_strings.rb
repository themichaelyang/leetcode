# For two strings s and t, we say "t divides s" if and only if
# s = t + t + t + ... + t + t
# (i.e., t is concatenated with itself one or more times).

# Given two strings str1 and str2, return the largest string x such
# that x divides both str1 and str2.

def overlap_length(str1, str2, max)
  i = 0

  until str1[i] != str2[i] || i >= max
    i += 1
  end

  i
end

def divides?(str, substr_len)
  substr_len.times do |offset|
    repeated = str.length / substr_len

    repeated.times do |r|
      return false unless str[offset] == str[r * substr_len + offset]
    end
  end

  true
end

# @param {String} str1
# @param {String} str2
# @return {String}
def gcd_of_strings(str1, str2)
  return str1 if str1 == str2

  max_gcd = str1.length.gcd(str2.length)
  max_overlap = overlap_length(str1, str2, max_gcd)

  divisors = (1..max_overlap).select do |substr_len|
    (str1.length % substr_len).zero? && \
      (str2.length % substr_len).zero? && \
      divides?(str1, substr_len) && \
      divides?(str2, substr_len)
  end

  gcd = divisors.max
  gcd ? str1[...gcd] : ''
end

# interesting solution I learned about:
#
# assume gcd of t, then
#
# str1 = t * n
# str2 = t * m
#
# str1 <> str2 = t * (n + m) = str2 <> str1
#
# Proof that the GCD is the longest is a bit more involved
# and I haven't see writeup online I like yet.

# def gcd_of_strings(str1, str2)
#   return "" unless str1 + str2 == str2 + str1
#   str1[...str1.length.gcd(str2.length)]
# end

require_relative 'testing'

Testing.expect(gcd_of_strings('ABCABC', 'ABC'), 'ABC')
Testing.expect(gcd_of_strings('ABABAB', 'ABAB'), 'AB')
Testing.expect(gcd_of_strings('LEET', 'CODE'), '')
Testing.expect(gcd_of_strings('AAAAAB', 'AAA'), '')
Testing.expect(gcd_of_strings('AAAAAB', 'A'), '')
Testing.expect(gcd_of_strings('AAAAA', 'AA'), 'A')
Testing.expect(gcd_of_strings('AAAAAA', 'AA'), 'AA')
Testing.expect(divides?('AAAAAB', 3), false)
Testing.expect(gcd_of_strings(
  "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
  "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"), "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
)
Testing.summary
