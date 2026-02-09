# There are n kids with candies. You are given an integer array candies,
# where each candies[i] represents the number of candies the ith kid has,
# and an integer extraCandies, denoting the number of extra candies that
# you have.

# Return a boolean array result of length n, where result[i] is true if,
# after giving the ith kid all the extraCandies, they will have the greatest
# number of candies among all the kids, or false otherwise.

# Note that multiple kids can have the greatest number of candies.

# @param {Integer[]} candies
# @param {Integer} extra_candies
# @return {Boolean[]}
def kids_with_candies(candies, extra_candies)
  max = candies.max
  candies.map { |c| c + extra_candies >= max }
end

require_relative './testing'

Testing.expect(
  kids_with_candies([4, 2, 1, 1, 2], 1),
  [true, false, false, false, false]
)
Testing.expect(kids_with_candies(
  [12, 1, 12], 10),
  [true, false, true]
)
Testing.summary
