# You have a long flowerbed in which some of the plots are planted, and some are not.
# However, flowers cannot be planted in adjacent plots.

# Given an integer array flowerbed containing 0's and 1's, where 0 means empty
# and 1 means not empty, and an integer n, return true if n new flowers can be
# planted in the flowerbed without violating the no-adjacent-flowers rule and
# false otherwise.

# @param {Integer[]} flowerbed
# @param {Integer} n
# @return {Boolean}
def can_place_flowers(flowerbed, n)
  adjacent_empty = 0
  plantable = 0

  if flowerbed[0] == 0
    adjacent_empty += 1
  end

  flowerbed.length.times do |i|
    # need to put the i + 1 check here to handle length = 1 case
    if flowerbed[i] == 0 && (flowerbed[i + 1] == 0 || i + 1 == flowerbed.length)
      adjacent_empty += 1
    elsif adjacent_empty != 0
      plantable += adjacent_empty / 2
      adjacent_empty = 0
    end
  end

  plantable += adjacent_empty / 2
  plantable >= n
end

require './testing'

Testing.expect(can_place_flowers([1, 0, 0, 0, 0], 1), true)
Testing.expect(can_place_flowers([0, 0, 0, 0], 2), true)
Testing.expect(can_place_flowers([0, 0, 0, 0], 3), false)

Testing.expect(can_place_flowers([0, 0, 0, 0, 1], 1), true)
Testing.expect(can_place_flowers([0, 0, 0, 0, 1], 2), true)
Testing.expect(can_place_flowers([0, 0, 0, 0, 1], 3), false)

Testing.expect(can_place_flowers([0], 1), true)
Testing.expect(can_place_flowers([1], 1), false)
Testing.expect(can_place_flowers([1, 1, 1], 1), false)

Testing.expect(can_place_flowers([1, 0, 0, 1], 1), false)
Testing.expect(can_place_flowers([1, 0, 0, 0, 1], 1), true)
Testing.expect(can_place_flowers([1, 0, 0, 0, 1], 2), false)
