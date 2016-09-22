require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(index + @start_idx) % capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(index + @start_idx) % capacity] = val
  end

  # O(1)
  def pop
    check_index(@length - 1)
    popped_el = @store[(@start_idx + @length - 1) % @capacity]
    @length -= 1
    popped_el
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    check_index(0)
    shifted_el = @store[@start_idx]
    @start_idx += 1
    @start_idx %= @capacity
    @length -= 1
    shifted_el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx -= 1
    @start_idx = @capacity - 1 if @start_idx < 0
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if @length == 0 || !index.between?(0, @length-1)
  end

  def resize!
    temp = StaticArray.new(capacity * 2)
    (0...@length).each do |idx|
      if idx >= @start_idx
        temp[idx] = @store[idx]
      else
        temp[idx + @length] = store[idx]
      end
    end
    @start_idx %= (capacity * 2)
    @capacity *= 2
    @store = temp
  end
end
