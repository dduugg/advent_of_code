# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 7: No Space Left On Device ---
class NoSpaceLeftOnDevice < Solver
  class Listing < T::Struct
    const :name, String
    const :parent, T.nilable(Listing)
    const :children, T.nilable(T::Set[Listing]), default: Set.new
    prop :size, Integer, default: 0
  end

  def initialize(filepath)
    super
    @root = Listing.new(name: '/', parent: nil)
    @pos = @root
    @lines.each { parse_line(_1) }
  end

  def parse_line(line)
    case line.split
    in ['$', 'cd', dirname] then cd(dirname)
    in ['dir', dirname] then dir(dirname)
    in ['$', 'ls'] # no-op
    in [size, name] then file(size.to_i, name)
    else raise "Unexpected line #{line}"
    end
  end

  def file(size, name)
    return if @pos.children.any? { _1.name == name }

    @pos.children << Listing.new(name:, parent: @pos, children: nil, size:)
    parent = @pos
    while parent
      parent.size += size
      parent = parent.parent
    end
  end

  def dir(name)
    @pos.children << Listing.new(name:, parent: @pos) if @pos.children.none? { _1.name == name }
  end

  def cd(dir)
    @pos = case dir
           when '/' then @root
           when '..' then @pos.parent || @root
           else @pos.children.find { _1.name == dir }
           end
  end

  def visit
    q = Queue.new([@root])
    until q.empty?
      dir = q.deq
      dir.children.each { q.enq(_1) if _1.children } if yield dir
    end
  end

  def sum_dirs(limit)
    sum = 0
    visit { _1.size <= limit ? sum += _1.size : true }
    sum
  end

  def dir_size_to_del(max_dir_space)
    needed_space = @root.size - max_dir_space
    to_del = @root
    visit { (_1.size < to_del.size ? to_del = _1 : true) if _1.size > needed_space }
    to_del.size
  end
end
