# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

# --- Day 11: Dumbo Octopus ---
class DumboOctopus < GridSolver
  Elem = type_member(:out) { { fixed: Coordinate } }

  sig { returns(Integer) }
  attr_reader :flash_count

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @flash_count = T.let(0, Integer)
    @flash_queue = T.let(Queue.new, Queue)
    @flashed = T.let(Set.new, T::Set[GridSolver::Coordinate])
    @int_grid = T.let(@grid.transform_values(&:to_i), T::Hash[Coordinate, Integer])
  end

  sig { params(num_steps: Integer).returns(T.self_type) }
  def step(num_steps)
    num_steps.times { take_step }
    self
  end

  sig { void }
  def take_step
    @int_grid.each_key { |coord| step_coordinate(coord) }
    process_flash_queue
  end

  sig { params(coord: GridSolver::Coordinate).void }
  def flash(coord)
    @int_grid[coord] = 0
    @flash_queue.push(coord)
    @flashed << coord
  end

  sig { void }
  def process_flash_queue
    until @flash_queue.empty?
      coord = @flash_queue.pop
      neighbors(coord).each { |neighbor| step_coordinate(neighbor) }
    end
    @flash_count += @flashed.size
    @flashed.clear
    @flash_queue.clear
  end

  sig { params(coord: GridSolver::Coordinate).void }
  def step_coordinate(coord)
    return if @flashed.include?(coord)

    @int_grid[coord] == 9 ? flash(coord) : @int_grid[coord] = @int_grid.fetch(coord) + 1
  end

  sig { returns(Integer) }
  def steps_until_synchronized
    count = 0
    until synchronized?
      take_step
      count += 1
    end
    count
  end

  sig { returns(T::Boolean) }
  def synchronized? = @int_grid.all? { |_, val| val.zero? }
end
