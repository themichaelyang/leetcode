# You are given an array of non-overlapping intervals intervals
# where intervals[i] = [start_i, end_i] represent the start and the end of the ith interval
# and intervals is sorted in ascending order by start_i.
# You are also given an interval newInterval = [start, end]
# that represents the start and end of another interval.

# Insert newInterval into intervals such that intervals is still sorted in ascending order
# by start_i and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

# Return intervals after the insertion.

# Note that you don't need to modify intervals in-place. You can make a new array and return it.

def overlap?(a, b)
  # could also use Range#cover?
  !(a.last < b.first || b.last < a.first)
end

# a strictly before b?
def before?(a, b)
  a.last < b.first
end

# a strictly after b?
def after?(a, b)
  b.last < a.first
end

def merge(a, b)
  raise unless overlap?(a, b)
  [[a.first, b.first].min, [a.last, b.last].max]
end

# @param {Integer[][]} intervals
# @param {Integer[]} new_interval
# @return {Integer[][]}
def insert(intervals, new_interval)
  # insert before first interval that overlaps with or starts after new_interval
  # admittedly, i find bsearch pretty confusing, could naive loop instead
  insert_before = intervals.bsearch_index do |inter|
    !after?(new_interval, inter)
  end || intervals.length

  intervals.insert(insert_before, new_interval)

  # merge all overlapping with new interval. we only need to check from
  # new interval index because everything before is not overlapping
  (insert_before + 1).upto(intervals.length - 1).each do |i|
    if overlap?(intervals[insert_before], intervals[i])
      intervals[insert_before] = merge(intervals[insert_before], intervals[i])
      intervals[i] = nil
    else
      break
    end
  end

  intervals.compact
end

require_relative './testing'

Testing.expect(
  insert([[1,3],[6,9]], [2,5]),
  [[1,5],[6,9]]
)
Testing.expect(
  insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]),
  [[1,2],[3,10],[12,16]]
)
Testing.expect(
  insert([[1, 1]], [1, 1]),
  [[1, 1]]
)
Testing.expect(
  insert([[1, 2]], [1, 3]),
  [[1, 3]]
)
Testing.expect(
  insert([[1, 2], [4, 4]], [1, 5]),
  [[1, 5]]
)
Testing.expect(
  insert([[2, 3], [5, 6]], [1, 3]),
  [[1, 3], [5, 6]]
)
Testing.expect(
  insert([[1, 2], [4, 4]], [2, 5]),
  [[1, 5]]
)
Testing.expect(
  insert([[2, 3]], [1, 4]),
  [[1, 4]]
)
Testing.expect(
  insert(
    [[1, 1], [3, 3], [5, 5], [6, 7]],
    [3, 6]
  ),
  [[1, 1], [3, 7]]
)
Testing.expect(
  insert(
    [[0, 2], [4, 5], [7, 9], [11, 12]],
    [1, 8]
  ),
  [[0, 9], [11, 12]]
)

Testing.expect(
  insert(
    [[0, 2], [4, 5], [7, 9], [11, 12]],
    [0, 12]
  ),
  [[0, 12]]
)
Testing.expect(
  insert(
    [[1, 2], [4, 5], [7, 9], [11, 12]],
    [0, 13]
  ),
  [[0, 13]]
)
Testing.expect(
  insert([], [1, 2]),
  [[1, 2]]
)

Testing.expect(
  insert([[1, 2]], [0, 0]),
  [[0, 0], [1, 2]]
)
Testing.expect(
  insert([[0, 0]], [1, 2]),
  [[0, 0], [1, 2]]
)
Testing.summary
