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

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev if @next
    @prev.next = @next if @prev
  end
end

class LinkedList
  include Enumerable
  attr_accessor :first_node, :last_node
  def initialize
    @first_node = nil
    @last_node = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @first_node
  end

  def last
    @last_node
  end

  def empty?
    !@first_node && !@last_node
  end

  def get(key)
    node = @first_node
    while node
      return node.val if node.key==key
      node = node.next
    end
  end

  def include?(key)
    node = @first_node
    # return false unless node
    while node
      return true if node.key == key
      node = node.next
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key,val)
    if @first_node == nil && @last_node == nil
      @first_node = new_link
      @last_node = new_link
    else
      @last_node.next = new_link
      new_link.prev = @last_node
      @last_node = new_link
    end
  end

  def update(key, val)
    node = @first_node

    while node
      if node.key == key
        node.val = val
        break
      end
      node = node.next
    end
  end

  def remove(key)
    node = @first_node

    while node
      if node.key == key
        node.remove
        unless node.prev
          @first_node = node.next
        end
        unless node.next
          @last_node = node.prev
        end
        break
      end
      node = node.next
    end
  end

  def each(&prc)
    prc ||= Proc.new{|link| puts link.val}
    node = @first_node
    while node
      prc.call(node)
      node = node.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
