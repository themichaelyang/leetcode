# https://leetcode.com/problems/maximum-fruits-harvested-after-at-most-k-steps/description/

# Observations:
# - It only makes sense to change direction once. If you do so, then you have to 2x the distance you went.
# - This seems a lot like #1432.

# Ishaan says: no need to optimize for sparse solution. Iterating over k is acceptable.
# Try for simplest solution first!

# Ishaan's solution: https://pastebin.com/XU5uJhuf

# Here is my solution, ignoring the sparse optimization, so we iterate over k. Originally, I wanted to only keep track
# of the locations with fruit.
# def max_total_fruits(fruits, start_pos, k)
#   steps = []

#   fruits.each do |pos, amount|
#     steps[pos] = amount
#   end

#   right_sum = 0
#   right_cumulative = start_pos.upto(start_pos + k).map do |i|
#     right_sum += (steps[i] || 0)
#   end

#   left_sum = 0
#   # Need to max because ruby will wrap around with negative indexes
#   left_cumulative = start_pos.downto([0, start_pos - k].max).map do |i|
#     left_sum += (steps[i] || 0)
#   end

#   # puts right_cumulative.inspect
#   # puts left_cumulative.inspect
#   # puts steps[start_pos]

#   start_fruit = (steps[start_pos] || 0)

#   right_first = right_cumulative.each_with_index.map do |right_sum, rightmost|
#     # right first, then turn left
#     # We need to bound it within left_cumulative.length - 1, so that we're getting the maximum left sum if we exceed the bounds
#     leftmost = [[0, k - rightmost * 2].max, left_cumulative.length - 1].min
    
#     # left/right cumulative include the start_fruit, so we subtract to avoid double counting.
#     # because of the subtraction, if there is no left cumulative sum, then we add start_fruit
#     [right_sum + (left_cumulative[leftmost] || start_fruit) - start_fruit, [leftmost, rightmost, 'right-first']]
#   end
  
#   left_first = left_cumulative.each_with_index.map do |left_sum, leftmost|
#     # left first, then turn right
#     rightmost = [[0, k - leftmost * 2].max, right_cumulative.length - 1].min
#     [left_sum + (right_cumulative[rightmost] || start_fruit) - start_fruit, [leftmost, rightmost, 'left-first']]
#   end

#   (right_first + left_first).max[0]
# end

# Sparse solution — only uses fruits, doesn't create an array entry
# for every single pos.
def max_total_fruits(fruits, start_pos, k)
  # Get indexes around start
  # Smallest index with fruit that is >= start_pos
  start_pos_index = fruits.bsearch_index {|pos, _fruits| pos >= start_pos} || fruits.length

  # If the min index position is not the start pos, insert the start pos
  if fruits.dig(start_pos_index, 0) != start_pos
    fruits.insert(start_pos_index, [start_pos, 0])
  end

  # Compute the prefix sums
  left_cumulative = cumulative_fruits(start_pos_index.upto(fruits.length - 1), fruits, start_pos)
  right_cumulative = cumulative_fruits(start_pos_index.downto(0), fruits, start_pos)

  # puts start_pos, k
  # puts left_cumulative.inspect
  # puts right_cumulative.inspect

  # We start at the most steps on the right side to maximize the fruits. 
  # Since we are increasing the left steps, the steps on the right must be <= the previous
  # right steps to maximize fruits, so we can iterate down (and only go through right_cumulative once)
  left_first_right_index = right_cumulative.length - 1
  left_first = left_cumulative.map do |left_steps, left_total|
    right_steps, right_total = right_cumulative[left_first_right_index]
    # If we go left first, then we need to turn back to go right
    total_steps = left_steps * 2 + right_steps

    while total_steps > k && left_first_right_index > 0
      left_first_right_index -= 1
      right_steps, right_total = right_cumulative[left_first_right_index]
      total_steps = left_steps * 2 + right_steps
    end

    if total_steps > k
      [0, 'left', left_steps, right_steps]
    else
      [right_total + left_total - fruits[start_pos_index][1], 'left', left_steps, right_steps]
    end
  end

  right_first_left_index = left_cumulative.length - 1
  right_first = right_cumulative.map do |right_steps, right_total|
    left_steps, left_total = left_cumulative[right_first_left_index]
    total_steps = right_steps * 2 + left_steps

    while total_steps > k && right_first_left_index > 0
      right_first_left_index -= 1
      left_steps, left_total = left_cumulative[right_first_left_index]
      total_steps = right_steps * 2 + left_steps
    end

    if total_steps > k
      [0, 'right', left_steps, right_steps]
    else
      [right_total + left_total - fruits[start_pos_index][1], 'right', left_steps, right_steps]
    end
  end

  # puts (left_first + right_first).inspect

  (left_first + right_first).max[0]
end

def cumulative_fruits(iter, fruits, start_pos)
  steps = 0
  sum = 0
  iter.map do |i|
    pos, fruit = fruits[i]
    [(pos - start_pos).abs, sum += fruit]
  end
end

@test_cases = 0
@test_cases_passed = 0

def test(actual, expected)
  @test_cases += 1
  puts "TEST CASE #{@test_cases}"
  if actual != expected
    puts "> ❌ found: #{actual}, expected: #{expected}"
  else
    puts "> ✅ passed!"
    @test_cases_passed += 1
  end

  puts
end

# fruits = [[2,8],[6,3],[8,6]], startPos = 5, k = 4
test(max_total_fruits([[2,8],[6,3],[8,6]], 5, 4), 9)
test(max_total_fruits([[0,9],[4,1],[5,7],[6,2],[7,4],[10,9]], 5, 4), 14)
test(max_total_fruits([[200000,10000]], 0, 0), 0)
test(max_total_fruits([[0,10000]], 200000, 200000), 10000)
test(max_total_fruits([[0,10000]], 200000, 0), 0)
test(max_total_fruits([[0,10000]], 0, 200000), 10000)
test(max_total_fruits([[0,10]], 0, 2), 10)
test(max_total_fruits([[0,15],[3,56],[4,98],[5,81],[7,16],[8,77],[9,89],[12,82],[13,49],[14,59],[17,40],[18,83],[19,35],[20,31],[21,44],[22,92],[25,84],[26,42],[29,4],[33,78],[35,83],[36,3],[37,71],[41,24],[44,81],[45,35],[46,81],[48,81],[50,85],[52,32],[53,93],[54,89],[55,82],[56,60],[59,52],[62,79],[63,90],[64,41],[66,15],[68,43],[69,32],[70,51],[71,79],[75,39],[76,21],[78,16],[79,44],[80,73],[81,95],[83,95],[85,11],[87,80],[88,2],[90,89],[99,35],[100,95]], 86, 107), 3102)

puts "#{@test_cases_passed} / #{@test_cases} test cases passed"