# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 12: Passage Pathing ---
class PassagePathing < Solver
  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @graph = Hash.new { |h, k| h[k] = Set.new }
    init_graph
    @large_caves, @small_caves = @graph.keys.partition { _1.match?(/\A[[:upper:]]+\z/) }.map(&:to_set)
    T.must(@small_caves).delete_if { %w[start end].include?(_1) }
  end

  sig { params(revisit: T::Boolean).returns(Integer) }
  def count_paths(revisit: false)
    @count = 0
    # https://github.com/sorbet/sorbet/pull/6588
    q = Queue.new
    q << ['start']
    process_path(q, revisit:) until q.empty?
    @count
  end

  sig { void }
  def init_graph
    @lines.each do |line|
      l, r = line.split('-')
      @graph[l] << r if r != 'start'
      @graph[r] << l if l != 'start'
    end
  end

  sig { params(queue: Queue, revisit: T::Boolean).void }
  def process_path(queue, revisit:)
    path = queue.pop
    @graph[path.last].each do |next_node|
      if next_node == 'end'
        @count += 1
      elsif can_visit?(next_node, path, revisit:)
        queue.push(path + [next_node])
      end
    end
  end

  sig { params(cave: String, path: T::Array[String], revisit: T::Boolean).returns(T::Boolean) }
  def can_visit?(cave, path, revisit:)
    return true if @large_caves.include?(cave) || !path.include?(cave)
    return false unless revisit

    small_cave_stops = path.select { @small_caves.include?(_1) }
    small_cave_stops.uniq.size == small_cave_stops.size
  end
end
