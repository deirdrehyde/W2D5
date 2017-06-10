class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = 0
    self.each_with_index do |el, idx|
      num += (el.hash + idx).hash
    end
    num
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    string_array = self.downcase.chars
    num = 0
    big_prime_num = 1637
    string_array.each_with_index do |char, idx|
      num += ((alphabet.find_index(char)*1637).hash + idx).hash
    end
    num
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array_keys = []
    self.each do |k,v|
      array_keys << k
    end
    array_keys.sort!
    array_keysandvalues = []
    alphabet = ("a".."z").to_a
    array_keys.each do |key|
      value = self[key]
      unless key.is_a?(Integer)
        key = key.to_s.hash
      end
      unless value.is_a?(Integer)
        value = value.to_i
      end
      array_keysandvalues << key
      array_keysandvalues << value
    end
    array_keysandvalues.hash
  end
end
