# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D06 < GridSolver
  Elem = type_member(:out) { { fixed: [Integer, Integer] } }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/06/#{filepath}")
    @guard = T.let(T.must(find { |x, y| @grid[[x, y]] == '^' }), Coordinate)
    @guard_dir = T.let(Direction::North, Direction)
    @visited = T.let(Set[[@guard, @guard_dir]], T::Set[[Coordinate, Direction]])
  end

  sig { returns(T.nilable(Integer)) }
  def part1 = count_visits(@guard, @guard_dir, @grid.dup)

  sig do
    params(guard: Coordinate, guard_dir: Direction, grid: T::Hash[Coordinate, String])
      .returns(T.nilable(Integer))
  end
  def count_visits(guard, guard_dir, grid)
    until out_of_bounds?(guard)
      new_guard, guard_dir = move(guard, guard_dir, grid)
      return nil if @visited.include?([new_guard, guard_dir])

      @visited << [new_guard, guard_dir]
      grid[guard] = 'X'
      guard = new_guard
    end
    @visited.map(&:first).uniq.size - 1
  end

  sig do
    params(guard: Coordinate, guard_dir: Direction, grid: T::Hash[Coordinate, String])
      .returns([Coordinate, Direction])
  end
  def move(guard, guard_dir, grid)
    x, y = guard
    next_pos = case guard_dir
               when Direction::North then [x, y - 1]
               when Direction::East then [x + 1, y]
               when Direction::South then [x, y + 1]
               when Direction::West then [x - 1, y]
               else T.absurd(guard_dir)
               end
    if grid[next_pos] == '#'
      guard_dir = guard_dir.turn_right
    else
      guard = next_pos
    end
    [guard, guard_dir]
  end

  sig { returns(Integer) }
  def part2
    part1
    blocks = @visited.map(&:first).uniq
    blocks.count do |coord|
      grid = @grid.dup
      @visited = Set[[@guard, @guard_dir]]
      grid[coord] = '#'
      count = count_visits(@guard, @guard_dir, grid)
      count.nil?
    end - 1
  end
end
