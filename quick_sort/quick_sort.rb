class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array.drop(1).each do |el|
      if el <= pivot
        left << el
      else
        right << el
      end
    end
    QuickSort.sort1(left).concat([pivot].concat(QuickSort.sort1(right)))
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - (pivot_idx - start) - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }
    pivot_idx = start
    (start + 1...start + length).each do |idx|
      if prc.call(array[pivot_idx], array[idx]) == 1
        array[pivot_idx + 1], array[idx] = array[idx], array[pivot_idx + 1]
        array[pivot_idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[pivot_idx]
        pivot_idx = pivot_idx + 1
      end
    end
    pivot_idx
  end
end

arr = [1, 2, 3, 4, 5]

num_comparisons = 0
QuickSort.sort2!(arr) do |el1, el2|
  p [el1, el2]
  num_comparisons += 1
  el1 <=> el2
end
