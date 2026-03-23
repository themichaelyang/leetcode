# Design an algorithm to encode a list of strings to a string.
# The encoded string is then sent over the network and is decoded
# back to the original list of strings.
#
# (neetcode since leetcode was paywalled)

class Solution:
  def encode(self, strs: list[str]) -> str:
    ret = []

    for str in strs:
      for c in str:
        if c == "," or c == "\\":
          ret += "\\" + c
        else:
          ret += c
      ret += ','

    return "".join(ret)

  def decode(self, s: str) -> list[str]:
    strs = []
    current = []
    escape_next = False

    for c in s:
      if not escape_next and c == "\\":
        escape_next = True
      elif escape_next:
        current.append(c)
        escape_next = False
      elif c == ",":
        strs.append("".join(current))
        current = []
      else:
        current.append(c)

    return strs

def test_roundtrip(strs):
  codec = Solution()
  assert codec.decode(codec.encode(strs)) == strs, codec.encode(strs)

codec = Solution()
test_roundtrip(["hello", "world"])
test_roundtrip(["a"])
test_roundtrip(["a\\"])
test_roundtrip(["a\\", "b\\"])
test_roundtrip(["a,", "b,"])
test_roundtrip(["a\\,", "b"])
test_roundtrip(["a\\\\", "b"])
test_roundtrip(["a\\", ",b"])
test_roundtrip(["one", "two", "three", "four"])
