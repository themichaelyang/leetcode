# Given an array of characters chars, compress it using the following algorithm:

# Begin with an empty string s. For each group of consecutive repeating characters in chars:

# If the group's length is 1, append the character to s.
# Otherwise, append the character followed by the group's length.
# The compressed string s should not be returned separately, but instead, be stored in the input character array chars.
# Note that group lengths that are 10 or longer will be split into multiple characters in chars.

# After you are done modifying the input array, return the new length of the array.

# You must write an algorithm that uses only constant extra space.

# Note: The characters in the array beyond the returned length do not matter and should be ignored.

# @param {Character[]} chars
# @return {Integer}
def compress(chars)
  prev_char = nil
  next_index = 0
  prev_times = 1

  # need to add char at last index
  (chars.length + 1).times do |i|
    if chars[i] == prev_char
      prev_times += 1
    elsif prev_char
      chars[next_index] = prev_char
      next_index += 1

      if prev_times > 1
        len_str = prev_times.to_s
        chars[next_index...(next_index + len_str.length)] = len_str
        next_index += len_str.length
      end

      prev_times = 1
    end

    prev_char = chars[i]
  end

  next_index
end

def get_compressed(str)
  chars = str.chars
  compressed_len = compress(chars)
  [chars[...compressed_len].join, compressed_len]
end

require_relative 'testing'
Testing.expect(get_compressed('aabbccc'), ['a2b2c3', 6])
Testing.expect(get_compressed('a'), ['a', 1])
Testing.expect(get_compressed('aa'), ['a2', 2])
Testing.expect(get_compressed('aaa'), ['a3', 2])
Testing.expect(get_compressed('aaab'), ['a3b', 3])
Testing.expect(get_compressed('aaaba'), ['a3ba', 4])
Testing.summary
