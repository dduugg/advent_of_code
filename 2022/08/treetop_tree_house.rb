# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

# --- Day 8: Treetop Tree House ---
class TreetopTreeHouse < GridSolver
  Elem = type_member(:out) { { fixed: Coordinate } }

  # Represents a viewing direction
  class From < T::Enum
    enums do
      Left = new
      Right = new
      Top = new
      Bottom = new
    end
  end

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @int_grid = T.let(@grid.transform_values(&:to_i), T::Hash[Coordinate, Integer])
    @max_potential = T.let(
      @int_grid.to_h { |(col, row), _| [[col, row], col * (@num_cols - col - 1) * row * (@num_rows - row - 1)] },
      T::Hash[Coordinate, Integer]
    )
  end

  sig { params(dir: From, coords: T::Set[Coordinate]).void }
  def visible(dir, coords)
    order = [@num_cols, @num_rows]
    order.reverse! if [From::Left, From::Right].include?(dir)
    order.first.times do |outer|
      max_seen = T.let(-1, Integer)
      order.last.times do |inner|
        coord_col, coord_row = coord(outer, inner, dir)
        max_seen, height = check(coord_col, coord_row, max_seen, coords)
        break if height == 9
      end
    end
  end

  sig { params(outer: Integer, inner: Integer, dir: From).returns(Coordinate) }
  def coord(outer, inner, dir)
    case dir
    when From::Left then [inner, outer]
    when From::Right then [@num_cols - inner - 1, outer]
    when From::Top then [outer, inner]
    when From::Bottom then [outer, @num_rows - inner - 1]
    end
  end

  sig { params(col: Integer, row: Integer, max_seen: Integer, vis: T::Set[Coordinate]).returns([Integer, Integer]) }
  def check(col, row, max_seen, vis)
    height = @int_grid.fetch([col, row])
    if height > max_seen
      vis << [col, row]
      max_seen = height
    end
    [max_seen, height]
  end

  sig { returns(Integer) }
  def num_visible
    coords = Set.new
    From.each_value { visible(_1, coords) }
    coords.size
  end

  sig { params(col: Integer, row: Integer).returns(Integer) }
  def viewing_distance(col, row)
    height = @int_grid.fetch([col, row])
    T.must(From.values.map { count_dir(_1, col, row, height) }.reduce(&:*))
  end

  sig { params(dir: From, col: Integer, row: Integer, height: Integer).returns(Integer) }
  def count_dir(dir, col, row, height)
    case dir
    when From::Left then count_left(col, row, height)
    when From::Right then count_right(col, row, height)
    when From::Top then count_top(col, row, height)
    when From::Bottom then (((row + 1)...@num_rows).find { |row|
      @int_grid.fetch([col, row]) >= height
    } || (@num_rows - 1)) - row
    end
  end

  sig { params(col: Integer, row: Integer, height: Integer).returns(Integer) }
  def count_left(col, row, height) = col - (col - 1).downto(0).find { @int_grid.fetch([_1, row]) >= height }.to_i

  sig { params(col: Integer, row: Integer, height: Integer).returns(Integer) }
  def count_right(col, row, height)
    (((col + 1)...@num_cols).find { |c|
      @int_grid.fetch([c, row]) >= height
    } || (@num_cols - 1)) - col
  end

  sig { params(col: Integer, row: Integer, height: Integer).returns(Integer) }
  def count_top(col, row, height) = row - (row - 1).downto(0).find { @int_grid.fetch([col, _1]) >= height }.to_i

  sig { returns(Integer) }
  def max_viewing_product
    current_max = T.let(0, Integer)
    @max_potential.sort_by { |_, v| -v }.each do |(col, row), _potential|
      next if @int_grid.fetch([col, row]).zero?

      distance = viewing_distance(col, row)
      current_max = distance if distance > current_max
    end
    current_max
  end
end
