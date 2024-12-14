# typed: strict
# frozen_string_literal: true

require_relative 'solver'

# A general solver for Advent of Code grid problems
# Grid origin is top left corner, with x increasing to the right and y increasing down
class GridSolver < Solver
  Coordinate = T.type_alias { [Integer, Integer] }

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @grid = T.let({}, T::Hash[Coordinate, String])
    @lines.each_with_index do |line, row_num|
      line.chars.each_with_index do |char, col_num|
        @grid[[col_num, row_num]] = char
      end
    end
    @num_rows = T.let(@lines.size, Integer)
    @num_cols = T.let(@lines.fetch(0).size, Integer)
  end

  sig { returns(String) }
  def inspect = (0...@num_rows).map { |y| "#{(0...@num_cols).map { |x| @grid[[x, y]] }.join}\n" }.join

  sig { params(coord: Coordinate, include_diagonals: T::Boolean).returns(T::Array[Coordinate]) }
  def neighbors(coord, include_diagonals: true)
    x, y = coord
    [[x, y - 1], [x - 1, y], [x + 1, y], [x, y + 1]].concat(
      include_diagonals ? [[x - 1, y - 1], [x + 1, y - 1], [x - 1, y + 1], [x + 1, y + 1]] : []
    ).reject { |x2, y2| out_of_bounds?([x2, y2]) }
  end

  sig { params(coord: Coordinate).returns(T::Boolean) }
  def out_of_bounds?(coord)
    x, y = coord
    x.negative? || y.negative? || x >= @num_cols || y >= @num_rows
  end
end
