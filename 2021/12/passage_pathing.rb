# typed: ignore
# frozen_string_literal: true

require 'set'
require_relative '../../helper/solver'

# --- Day 12: Passage Pathing ---
class PassagePathing < Solver
  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @graph = Hash.new { _1[_2] = Set.new }
    @lines.each do |line|
      l, r = line.split('-')
      @graph[l] << r
      @graph[r] << l
    end
  end

  sig { params(revisit: T::Boolean).returns(Integer) }
  def count_paths(revisit: false)
    @count = 0
    q = Queue.new([['start']])
    process_path(q, revisit:) until q.empty? # rubocop:disable Layout/SpaceAfterColon
    @count
  end

  sig { params(queue: Queue, revisit: T::Boolean).void }
  def process_path(queue, revisit:)
    path = queue.pop
    @graph[path.last].each do |next_node|
      case next_node
      when 'end' then @count += 1
      when 'start' then next
      else queue.push(path + [next_node]) if can_visit?(next_node, path, revisit:) # rubocop:disable Layout/SpaceAfterColon
      end
    end
  end

  sig { params(cave: String, path: T::Array[String], revisit: T::Boolean).returns(T::Boolean) }
  def can_visit?(cave, path, revisit:)
    return true if cave.match?(/\A[[:upper:]]+\z/) || !path.include?(cave)
    return false unless revisit

    small_cave_stops = path.select { _1.match?(/\A[[:lower:]]+\z/) && _1 != 'start' && _1 != 'end' }
    small_cave_stops.uniq.size == small_cave_stops.size
  end
end
