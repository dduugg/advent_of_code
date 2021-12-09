# typed: strict
# frozen_string_literal: true

require 'set'
require 'sorbet-runtime'

# --- Day 8: Seven Segment Search ---
# A class determine crab alignment when fuel costs increase linearly per step
class SmokeBasin
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    grid = File.readlines(filepath).map(&:chomp).map {[9] + _1.split('').map(&:to_i) + [9]}
    @grid = T.let(
      [Array.new(grid.first.size, 9)] + grid + [Array.new(grid.first.size, 9)],
      T::Array[T::Array[Integer]]
    )
  end

  sig { returns(T::Array[Integer]) }
  def low_points
    return @low_points if @low_points

    acc = []
    @grid.each_with_index do |row, y|
      row.each_with_index do |height, x|
        next if edge?(x,y)

        acc << height if low?(height, x, y)
      end
    end
    @low_points = acc
  end

  def edge?(x, y)
    y.zero? || x.zero? || y == @grid.size - 1 || x == @grid.first.size - 1
  end

  def low?(height, x, y)
    [@grid[y + 1][x], @grid[y][x + 1], @grid[y - 1][x], @grid[y][x-1]].min > height
  end

  def risk_level_sum
    low_points.sum + low_points.size
  end
end
