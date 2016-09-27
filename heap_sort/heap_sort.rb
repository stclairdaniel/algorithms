require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new {|a,b| a <=> b}
    heap = BinaryMinHeap.new(&prc)
    right_bound = 0
    while right_bound < length
      heap.push(self[right_bound])
      right_bound += 1
    end
    left_bound = length
    res = []
    while left_bound > 0
      left_bound -= 1
      res << heap.extract
    end
    (0...res.length).each do |i|
      self[i] = res[i]
    end
    self
  end
end
