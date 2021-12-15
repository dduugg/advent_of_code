# typed: ignore
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 13: Transparent Origami ---
class TransparentOrigami < Solver
  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @points = T.let([], T::Array[{ x: Integer, y: Integer }])
    init_points
    @size_x = T.let(@points.map { _1[:x] }.max + 1, Integer)
    @size_y = T.let(@points.map { _1[:y] }.max + 1, Integer)
  end

  sig { params(limit: T.nilable(Integer)).returns(T.self_type) }
  def fold(limit = nil)
    @lines.select { _1.start_with?('fold along ') }.each_with_index do |line, index|
      break if limit && index >= limit

      axis, index = line[11..].split('=')
      exec_fold(axis.to_sym, index.to_i)
    end
    self
  end

  sig { params(axis: Symbol, index: Integer).void }
  def exec_fold(axis, index)
    @points.each do |coord|
      next if coord.public_send(:[], axis) < index

      coord.public_send(:[]=, axis, (2 * index) - coord.public_send(:[], axis))
    end
    @points.uniq!
    instance_variable_set("@size_#{axis}", index)
  end

  sig { returns(Integer) }
  def dot_count = @points.size

  sig { void }
  def init_points
    @points = @lines.select {_1.include?(',')}.map do |line|
      x, y = line.split(',').map(&:to_i)
      { x:, y: }
    end
  end

  sig { returns(String) }
  def inspect
    Array.new(@size_y) do |y|
      Array.new(@size_x) { |x| @points.include?({ x:, y: }) ? '#' : '.' } + ["\n"]
    end.join
  end
end
