class MaxHeap
  def self.parent_index(i)
    raise if i <= 0
    (i - 1) / 2
  end

  def self.left_index(i)
    raise if i < 0
    2 * i + 1
  end

  def self.right_index(i)
    raise if i < 0
    2 * i + 2
  end

  # could also use Forwardable and def_delegator
  def length
    @arr.length
  end

  def swap_places!(i1, i2)
    @arr[i1], @arr[i2] = @arr[i2], @arr[i1]
  end

  # assumes left and right are already max heaps
  # called "max heapify" or "float down" in clrs, or "sink"
  def sift_down!(i)
    return if i < 0
    index_of_largest = [MaxHeap.left_index(i), MaxHeap.right_index(i), i].max_by { |j| @arr[j] || -Float::INFINITY }

    if i != index_of_largest
      swap_places!(i, index_of_largest)
      sift_down!(index_of_largest)
    end
  end

  def bubble_up!(i)
    return if i <= 0
    parent_i = MaxHeap.parent_index(i)

    if @arr[parent_i] < @arr[i]
      swap_places!(parent_i, i)
      bubble_up!(parent_i)
    end
  end

  def build!
    ((length / 2) - 1).downto(0) do |i|
      sift_down!(i)
    end
  end

  def initialize(arr=[])
    @arr = arr
    build!
  end

  def peek
    @arr.first
  end

  # remove and return largest (first) element of heap
  def pop!
    return @arr.pop if length <= 1

    largest = peek
    @arr[0] = @arr.pop # removes last element of @arr
    sift_down!(0)

    largest
  end

  def push!(val)
    @arr.push(val)
    bubble_up!(length - 1)
  end

  def to_a
    @arr
  end
end
