class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = BSTNode.new(nil)
  end

  def insert(value)
    if @root.value.nil?
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    return nil unless @root.value
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    return nil unless @root.value
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    return nil unless @root.value
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    return nil unless @root.value
    BinarySearchTree.preorder!(@root)
  end

  def height
    return -1 unless @root.value
    BinarySearchTree.height!(@root)
  end

  def min
    return nil unless @root.value
    BinarySearchTree.min(@root)
  end

  def max
    return nil unless @root.value
    BinarySearchTree.max(@root)
  end

  def delete(value)
    return nil unless @root.value
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node
    if value <= node.value
      node.left = insert!(node.left, value)
    else
      node.right = insert!(node.right, value)
    end
    return node
  end

  def self.find!(node, value)
    return nil unless node
    return node if node.value == value
    if value <= node.value
      find!(node.left, value)
    else
      find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    res = []
    res << node.value
    res << preorder!(node.left) if node.left
    res << preorder!(node.right) if node.right
    res.flatten
  end

  def self.inorder!(node)
    return [] unless node
    res = []
    res << preorder!(node.left) if node.left
    res << node.value
    res << preorder!(node.right) if node.right
    res.flatten
  end

  def self.postorder!(node)
    return [] unless node
    res = []
    res << postorder!(node.left) if node.left
    res << postorder!(node.right) if node.right
    res << node.value
    res.flatten
  end

  def self.height!(node)
    return -1 unless node
    left_height = 1 + height!(node.left)
    right_height = 1 + height!(node.right)
    return [left_height, right_height].max

  end

  def self.max(node)
    return nil unless node
    return node unless node.right
    return max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left
    return min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    if node.left
      node.left = delete_min!(node.left)
    else
      if node.right
        return node.right
      else
        return nil
      end
    end
  end

  def self.delete!(node, value)
    return nil unless node
    if value <= node.value
      node.left = delete!(node.left, value)
    else
      node.right = delete!(node.right, value)
    end
  end
end
