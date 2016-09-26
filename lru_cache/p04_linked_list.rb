class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    #reset val if key present
    each do |link|
      if link.key == key
        link.val = val
        return false
      end
    end

    link = Link.new(key, val)
    # head insertion
    # link.next = @head.next
    # link.prev = @head
    # @head.next = link
    # @head.next.prev = link

    #tail insertion
    link.next = @tail
    link.prev = @tail.prev
    @tail.prev.next = link
    @tail.prev = link
    return link
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.next.prev = link.prev
        link.prev.next = link.next
      end
    end
  end

  def each
    current = @head.next
    while current != @tail
      yield current
      current = current.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
