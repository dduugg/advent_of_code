# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

class Y2024D10 < GridSolver
  Elem = type_member(:out) { { fixed: [Integer, Integer] } }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/10/#{filepath}")
    @int_grid = T.let(@grid.transform_values(&:to_i), T::Hash[Coordinate, Integer])
  end

  sig { returns(Integer) }
  def part1 = @int_grid.each_key.sum { score(_1) }

  sig { params(coord: Coordinate, unique_paths: T::Boolean).returns(Integer) }
  def score(coord, unique_paths: false)
    return 0 unless @int_grid.fetch(coord).zero?

    queue = Queue.new([coord])
    peaks = []
    until queue.empty?
      current = queue.pop
      if @int_grid.fetch(current) == 9
        peaks << current
      else
        neighbors(current, include_diagonals: false).each do |neighbor|
          queue.push(neighbor) if @int_grid[neighbor] == @int_grid.fetch(current) + 1
        end
      end
    end
    unique_paths ? peaks.size : peaks.uniq.size
  end

  sig { returns(Integer) }
  def part2 = @int_grid.each_key.sum { score(_1, unique_paths: true) }
end
