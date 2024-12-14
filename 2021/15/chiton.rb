# typed: true
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

# --- Day 15: Chiton ---
class Chiton < GridSolver
  GRID_EXPANSION_FACTOR = 5
  START_COORD = T.let([0, 0].freeze, GridSolver::Coordinate)

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @int_grid = @grid.transform_values(&:to_i)
    @came_from = T.let({}, T::Hash[GridSolver::Coordinate, GridSolver::Coordinate])
  end

  sig { returns(Integer) }
  def a_star
    end_coord = [@num_cols - 1, @num_rows - 1]
    init_a_star_data
    until @open_set.empty?
      current = @open_set.min_by { @f_score[_1] }
      return sum_path(end_coord) if current == end_coord

      @open_set.delete(current)
      neighbors(current, include_diagonals: false).each { process_neighbor(current, _1) }
    end
    raise 'No path found'
  end

  sig { returns(T.self_type) }
  def expand_grid
    @num_cols *= GRID_EXPANSION_FACTOR
    @num_rows *= GRID_EXPANSION_FACTOR
    @num_cols.times do |x|
      @num_rows.times do |y|
        coord = [x, y]
        next if @int_grid[coord]

        @int_grid[coord] = new_grid_value(coord)
      end
    end
    self
  end

  sig { params(coord: GridSolver::Coordinate).returns(Integer) }
  def heuristic(coord) = (@num_cols - coord.first) + (@num_rows - coord.last) - 2

  sig { void }
  def init_a_star_data
    @open_set = Set.new([START_COORD])
    @came_from.clear
    @g_score = Hash.new { |h, k| h[k] = Float::INFINITY }
    @g_score[START_COORD] = 0
    @f_score = Hash.new { |h, k| h[k] = Float::INFINITY }
    @f_score[START_COORD] = heuristic(START_COORD)
  end

  sig { params(coord: GridSolver::Coordinate).returns(Integer) }
  def new_grid_value(coord)
    x, y = coord
    scale = @num_cols / GRID_EXPANSION_FACTOR
    result = @int_grid.fetch([x % scale, y % scale]) + (x / scale) + (y / scale)
    result > 9 ? result - 9 : result
  end

  sig { params(current: GridSolver::Coordinate, neighbor: GridSolver::Coordinate).void }
  def process_neighbor(current, neighbor)
    tentative_g_score = @g_score[current] + @int_grid[neighbor]
    return if tentative_g_score >= @g_score[neighbor]

    @came_from[neighbor] = current
    @g_score[neighbor] = tentative_g_score
    @f_score[neighbor] = tentative_g_score + heuristic(neighbor)
    @open_set << neighbor unless @open_set.include?(neighbor)
  end

  sig { params(current: GridSolver::Coordinate).returns(Integer) }
  def sum_path(current)
    total = 0
    while @came_from.key?(current)
      total += @int_grid.fetch(current)
      current = @came_from.fetch(current)
    end
    total
  end
end
