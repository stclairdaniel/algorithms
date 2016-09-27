class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    res = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    res
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    if count > 1
      BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
    end
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    res = []
    left_child = 2 * parent_index + 1
    right_child = 2 * parent_index + 2
    res << left_child if left_child < len
    res << right_child if right_child < len
    res
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    if block_given?
      children = child_indices(len, parent_idx)
      children.sort! {|a,b| prc.call(array[a], array[b]) }
      until children.empty? || !prc.call(array[parent_idx], array[children[0]])
        array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
        parent_idx = children[0]
        children = child_indices(len, parent_idx)
        children.sort! {|a,b| prc.call(array[a], [b]) }
      end
    else
      children = child_indices(len, parent_idx)
      children.sort!
      until children.empty? || array[parent_idx] < array[children[0]]
        array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
        parent_idx = children[0]
        children = child_indices(len, parent_idx)
        children.sort!
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent_idx = parent_index(child_idx)
    if block_given?
      until !prc.call(array[child_idx], array[parent_idx])
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        child_idx = parent_idx
        break if child_idx == 0
        parent_idx = parent_index(child_idx)
      end
    else
      until array[child_idx] >= array[parent_idx]
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        child_idx = parent_idx
        break if child_idx == 0
        parent_idx = parent_index(child_idx)
      end
    end
    array
  end
end
