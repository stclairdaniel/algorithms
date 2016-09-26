require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key] << key.hash
    @count += 1
  end

  def include?(key)
    self[key].include?(key.hash)
  end

  def remove(key)
    self[key].delete(key.hash)
    @count -= 1
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_set = HashSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |num|
        temp_set.insert(num)
      end
    end
    @store = temp_set.store
  end
end
