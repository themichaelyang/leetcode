# Given a string s, reverse only all the vowels in the string and return it.

# The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.

VOWELS = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']

# @param {String} s
# @return {String}
def reverse_vowels(s)
  left, right = 0, s.length - 1

  while left < right
    if VOWELS.include? s[left]
      if VOWELS.include? s[right]
        s[left], s[right] = s[right], s[left]
        left += 1
        right -= 1
      else
        right -= 1
      end
    else
      left += 1
    end
  end

  s
end

require './testing'
Testing.expect(reverse_vowels("IceCreAm"), "AceCreIm")
Testing.expect(reverse_vowels("a"), "a")
Testing.expect(reverse_vowels("b"), "b")
Testing.expect(reverse_vowels("ab"), "ab")
Testing.expect(reverse_vowels("abe"), "eba")
Testing.expect(reverse_vowels("ae"), "ea")
Testing.expect(reverse_vowels("bae"), "bea")
Testing.expect(reverse_vowels("baeb"), "beab")
Testing.expect(reverse_vowels("aeiou"), "uoiea")
Testing.expect(reverse_vowels("bacediou"), "bucodiea")
Testing.summary
