# typed: false
# frozen_string_literal: true

require 'set'
require 'sorbet-runtime'

# --- Day 8: Seven Segment Search ---
# A class determine crab alignment when fuel costs increase linearly per step
class SmokeBasin
  extend T::Sig

  Coordinate = T.type_alias { [Integer, Integer] }

  sig { params(filepath: String).void }
  def initialize(filepath)
    @grid = T.let(parse_file_into_grid(filepath), T::Array[T::Array[Integer]])
    @basin_map = T.let({}, T::Hash[Coordinate, Integer])
  end

  sig { params(col_pos: Integer, row_pos: Integer).returns(T::Array[Coordinate]) }
  def adjacent_points(col_pos, row_pos)
    [
      [col_pos + 1, row_pos],
      [col_pos, row_pos + 1],
      [col_pos - 1, row_pos],
      [col_pos, row_pos - 1]
    ].reject { |x, y| @grid[y][x] == 9 }
  end

  # parses the file into a grid, padding it with 9s all around to simplify some basin calculations
  sig { params(filepath: String).returns(T::Array[T::Array[Integer]]) }
  def parse_file_into_grid(filepath)
    grid = File.readlines(filepath).map(&:chomp).map {[9] + _1.split('').map(&:to_i) + [9]}
    [Array.new(grid.first.size, 9)] + grid + [Array.new(grid.first.size, 9)]
  end

  sig { params(basin_id: Integer, col_pos: Integer, row_pos: Integer).void }
  def populate_basin(basin_id, col_pos, row_pos)
    return if @basin_map[[col_pos, row_pos]] || @grid[row_pos][col_pos] == 9

    @basin_map[[col_pos, row_pos]] = basin_id
    adjacent_points(col_pos, row_pos).each do |x, y|
      next if @grid[y][x] == 9

      populate_basin(basin_id, x, y)
    end
  end

  sig { returns(T::Hash[Coordinate, Integer]) }
  def basin_map
    return @basin_map unless @basin_map.empty?

    basin_count = 0
    @grid.each_with_index do |row, y|
      row.each_with_index do |height, x|
        next if height == 9 || @basin_map[[x, y]]

        populate_basin(basin_count, x, y)
        basin_count += 1
      end
    end
    @basin_map
  end

  # @return The product of the size of the top_n largest basins
  sig { params(top_n: Integer).returns(Integer) }
  def basin_size_prouct(top_n = 3) = basin_map.values.tally.values.max(top_n).reduce(&:*)

  sig { returns(T::Array[Integer]) }
  def low_points
    return @low_points if @low_points

    acc = []
    @grid.each_with_index do |row, y|
      row.each_with_index do |height, x|
        next if edge?(x, y)

        acc << height if low?(height, x, y)
      end
    end
    @low_points = acc
  end

  sig { params(col_pos: Integer, row_pos: Integer).returns(T::Boolean) }
  def edge?(col_pos, row_pos)
    col_pos.zero? || row_pos.zero? || row_pos == @grid.size - 1 || col_pos == @grid.first.size - 1
  end

  sig { params(height: Integer, col_pos: Integer, row_pos: Integer).returns(T::Boolean) }
  def low?(height, col_pos, row_pos)
    [
      @grid[row_pos + 1][col_pos],
      @grid[row_pos][col_pos + 1],
      @grid[row_pos - 1][col_pos],
      @grid[row_pos][col_pos - 1]
    ].min > height
  end

  sig { returns(Integer) }
  def risk_level_sum = low_points.sum + low_points.size
end
