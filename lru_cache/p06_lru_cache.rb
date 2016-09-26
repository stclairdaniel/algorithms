require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      return link.val
    else
      link = calc!(key)
      eject! if count > @max
      return link.val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    link = @store.insert(key, val)
    @map.set(key, link)
    return link
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    link = @store.first
    @store.remove(link.key)
    @map.delete(link.key)
  end
end
