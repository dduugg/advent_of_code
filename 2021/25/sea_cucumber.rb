# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 25: Sea Cucumber ---
class SeaCucumber < Solver
  Coordinate = T.type_alias { [Integer, Integer] }

  # An enum representing a SeaCucumber orientation
  class Facing < T::Enum
    enums do
      East = new
      South = new
    end
  end

  # Duplicates some GridSolver code until it can handle String-valued coordinates
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
  def inspect = "\n#{(0...@num_rows).map { |y| "#{(0...@num_cols).map { |x| @grid[[x, y]] }.join}\n" }.join}"

  # @return the character corresponding to the given sea cucumber facing
  sig { params(facing: Facing).returns(String) }
  def char_for(facing) = facing == Facing::East ? '>' : 'v'

  # @return the coordinates a sea cucumber would be at if it were to move in the given direction
  sig { params(coord: Coordinate, facing: Facing).returns(Coordinate) }
  def next_coord(coord, facing)
    case facing
    when Facing::East then [coord[0] + 1 == @num_cols ? 0 : coord[0] + 1, coord[1]]
    when Facing::South then [coord[0], coord[1] + 1 == @num_rows ? 0 : coord[1] + 1]
    else T.absurd(facing)
    end
  end

  # Advance the grid for all sea cucumbers facing the given direction
  sig { params(facing: Facing).returns(T::Boolean) }
  def step(facing)
    new_hash = {}
    @grid.each do |coord, char|
      next if char != char_for(facing)

      new_coord = next_coord(coord, facing)
      next if @grid[new_coord] != '.'

      new_hash[new_coord] = char_for(facing)
      new_hash[coord] = '.'
    end
    @grid.merge!(new_hash)
    new_hash.empty?
  end

  # @note this may not terminate
  sig { returns(Integer) }
  def steps_until_stopped
    steps = 1
    steps += 1 until [step(Facing::East), step(Facing::South)].all?
    steps
  end
end
