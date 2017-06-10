class MaxIntSet

  def initialize(max)
    @store = Array.new(max)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true unless include?(num)
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num > 0
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num) unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if count == num_buckets
      @count = 0
      resize!
    end
    unless self[num].include?(num)
      self[num].push(num)
      @count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #we will double the size each time we resize it
    old_store = @store
    @store = Array.new(num_buckets*2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end
  end
end
