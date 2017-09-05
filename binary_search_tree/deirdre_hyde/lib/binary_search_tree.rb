# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root, :value
  def initialize
    @root = nil
  end

  def insert(value)

    unless @root
      @root = BSTNode.new(value)
      return
    end

    BinarySearchTree.insert!(@root, value)

  end

  def find(value, tree_node = @root)
    return nil unless tree_node

    return tree_node if tree_node.value == value
    if value <= tree_node.value
      return find(value, tree_node.left)
    end
    find(value, tree_node.right)

  end

  def delete(value)
    node = find(value)
    node = nil if maximum(node)

    @root = BinarySearchTree.delete!(@root, value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil unless tree_node
    return tree_node unless tree_node.right
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 unless tree_node
    left = depth(tree_node.left)
    right = depth(tree_node.right)
    left > right ? 1 + left : 1 + right
  end

  def is_balanced?(tree_node = @root)
    return true unless tree_node
    if (depth(tree_node.right) - depth(tree_node.left)).abs <= 1
      if is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
        return true
      end
    end
    false
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

  def self.insert!(node, value)
    return BSTNode.new(value) unless node
    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end

    node
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left

    end

    node
  end

end
