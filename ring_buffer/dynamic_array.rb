require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(@length - 1)
    popped_el = @store[@length - 1]
    @store[@length - 1] = nil
    @length -= 1
    popped_el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    first_el = @store[0]
    temp = StaticArray.new(@length)
    (1...@length).each do |idx|
      temp[idx - 1] = @store[idx]
    end
    @length -= 1
    @store = temp
    first_el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    old_length = @length
    resize! if @length == @capacity
    temp = StaticArray.new(@length)
    (0...old_length).each do |idx|
      temp[idx + 1] = @store[idx]
    end
    temp[0] = val
    @length += 1
    @store = temp
  end

  protected

  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if @length == 0 || !index.between?(0, @length-1)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    temp_store = StaticArray.new(@length * 2)
    (0...@length).each do |idx|
      temp_store[idx] = @store[idx]
    end
    @store = temp_store
    @capacity *= 2
  end
end
