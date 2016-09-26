class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    res = size
    (0...size).each do |idx|
      res += self[idx].hash * idx.hash
    end
    res
  end
end

class String
  def hash
    res = size
    chars.each_with_index do |char, i|
      res += char.ord.hash * i.hash
    end
    res
  end
end

class Hash
  def hash
    res = 0
    keys.each do |key|
      res += key.hash * self[key].hash
    end
    res
  end
end
