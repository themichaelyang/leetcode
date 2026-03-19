require './testing'
require_relative './max_heap'

def max_heap?(arr)
  arr.each_with_index.all? do |val, i|
    i == 0 || arr[MaxHeap.parent_index(i)] >= val
  end
end

def heapsort(arr)
  MaxHeap.new(arr).to_a.reverse
end

Testing.expect(MaxHeap.new.to_a, [])
Testing.expect(MaxHeap.new([1]).to_a, [1])
Testing.expect(MaxHeap.new([1, 2]).to_a, [2, 1])
Testing.expect(MaxHeap.new([1, 2, 3]).to_a, [3, 2, 1])
Testing.assert(max_heap?(MaxHeap.new([1, 2, 3]).to_a))
[71, 20, 30, 151, 12].tap {| arr| Testing.expect(arr.sort, heapsort(arr)) }
Testing.summary
