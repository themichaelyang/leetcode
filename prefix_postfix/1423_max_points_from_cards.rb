# https://leetcode.com/problems/maximum-points-you-can-obtain-from-cards/

def max_score(card_points, k)
  left_sums = cumulative_sum(card_points[0...k]).prepend(0)
  right_sums = cumulative_sum(card_points[-k..-1].reverse_each).reverse.append(0)

  left_sums.zip(right_sums).map(&:sum).max
end

def cumulative_sum(iter)
  sum = 0
  iter.map {|x| sum += x}
end

puts max_score([1,2,3,4,5,6,1], 3).inspect
