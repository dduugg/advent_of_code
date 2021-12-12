# typed: strict
# frozen_string_literal: true

require_relative './solver'

# A general solver for Advent of Code grid problems
# Grid origin is top left corner, with x increasing to the right and y increasing down
class GridSolver < Solver
  Coordinate = T.type_alias { [Integer, Integer] }

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @grid = T.let({}, T::Hash[Coordinate, Integer])
    @lines.each_with_index do |line, row_num|
      line.split('').each_with_index.map do |char, col_num|
        @grid[[col_num, row_num]] = char.to_i
      end
    end
    @num_rows = T.let(@lines.size, Integer)
    @num_cols = T.let(@lines.fetch(0).size, Integer)
  end

  sig { returns(String) }
  def inspect = (0...@num_rows).map { |y| "#{(0...@num_cols).map { |x| @grid[[x, y]] }.join}\n" }.join

  sig { params(coord: Coordinate).returns(T::Array[Coordinate]) }
  def neighbors(coord)
    x, y = coord
    [
      [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
      [x - 1, y],                 [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
    ].reject { |x2, y2| x2.negative? || y2.negative? || x2 >= @num_cols || y2 >= @num_rows }
  end
end
