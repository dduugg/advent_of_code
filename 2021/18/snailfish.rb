# typed: false
# frozen_string_literal: true

require 'json'
require_relative '../../helper/solver'

# --- Day 18: Snailfish ---
class Snailfish < Solver
  # Data structure for snailfish math
  class Node < T::Struct
    extend T::Sig

    prop :left, T.nilable(Node)
    prop :right, T.nilable(Node)
    prop :parent, T.nilable(Node)
    prop :value, T.nilable(Integer)

    sig { params(other: Node).returns(Node) }
    def +(other)
      sum = Node.new(left: self, right: other)
      self.parent = sum
      other.parent = sum
      loop { break if !sum.explode && !sum.split }
      sum
    end

    # depth is the distance from the outermost pair
    # used to determine if the pair is exploding
    sig { returns(Integer) }
    def depth
      generation = 0
      node = self
      generation += 1 while (node = node.parent)
      generation
    end

    # prevents stack overflows in pry
    sig { returns(String) }
    def inspect
      str = +"<#{self.class.name}"
      self.class.props.keys.each do |prop| # rubocop:disable Style/HashEachMethods
        if prop == :parent && parent
          str << " parent=#{parent.object_id}"
        elsif public_send(prop)
          str << " #{prop}=#{public_send(prop)}"
        end
      end
      str << '>'
    end

    sig { returns(Integer) }
    def magnitude
      left_magnitude = left.value || left.magnitude
      right_mganitude = right.value || right.magnitude
      (3 * left_magnitude) + (2 * right_mganitude)
    end

    sig { returns(T::Array[Node]) }
    def leaves = value ? [self] : left.leaves + right.leaves

    sig { returns(T::Array[T.untyped]) }
    def to_a = [left.value || left.to_a, right.value || right.to_a]

    sig { returns(T.nilable(Node)) }
    def pair_to_explode
      leaves.each { return _1.parent if _1.parent.explode? }
      nil
    end

    sig { returns(T::Boolean) }
    def explode? = !!(depth >= 4 && left.value && right.value)

    sig { returns(T::Boolean) }
    def explode
      return false unless (pair = pair_to_explode)

      leaves.each_cons(2) do |l, r|
        # the pair's left value is added to the first regular number to the left of the exploding pair (if any)
        l.value += r.value if r == pair.left
        # the pair's right value is added to the first regular number to the right of the exploding pair (if any)
        if l == pair.right
          r.value += l.value
          break
        end
      end
      # Then, the entire exploding pair is replaced with the regular number 0
      replace_with_zero(pair)
      true
    end

    sig { params(pair: Node).void }
    def replace_with_zero(pair)
      pair.value = 0
      pair.left = nil
      pair.right = nil
    end

    sig { returns(T::Boolean) }
    def split
      leaves.each do |node|
        val = node.value
        raise 'node is not a leaf' if val.nil?
        next if val < 10

        node.left = Node.new(value: val / 2, parent: node)
        node.right = Node.new(value: (val / 2) + (val % 2), parent: node)
        node.value = nil
        return true
      end
      false
    end
  end

  sig { params(arr: T::Array[T.untyped]).returns(Node) }
  def self.to_tree(arr)
    l = arr.first.is_a?(Array) ? to_tree(arr.first) : Node.new(value: arr.first)
    r = arr.last.is_a?(Array) ? to_tree(arr.last) : Node.new(value: arr.last)
    pair = Node.new(left: l, right: r)
    l.parent = pair
    r.parent = pair
    pair
  end

  sig { returns(Node) }
  def sum = @lines.map { self.class.to_tree(JSON.parse(_1)) }.reduce(:+) # rubocop:disable Performance/Sum

  # @returns the root node of the tree
  sig { params(line_no: Integer).returns(Node) }
  def line_to_tree(line_no) = self.class.to_tree(JSON.parse(@lines.fetch(line_no)))

  sig { returns(Integer) }
  def max_magnitude
    Array(0...@lines.size).permutation(2).map { |l, r| (line_to_tree(l) + line_to_tree(r)).magnitude }.max
  end
end
