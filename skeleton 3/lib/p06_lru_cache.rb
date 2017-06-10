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
      @map[key].remove
      update_link!(@map[key])
      return @store.first_node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_node = Link.new(key,val)
    update_link!(new_node)
    @map.set(key,new_node)
    return val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    initialfirstnode = @store.first
    @store.first_node.prev = link if @store.first
    @store.first_node = link
    @store.first_node.next = initialfirstnode
  end

  def eject!
  end
end
