# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

class Y2024D08 < GridSolver
  Elem = type_member(:out) { { fixed: [Integer, Integer] } }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/08/#{filepath}")
    @antenna_map = T.let({}, T::Hash[String, T::Set[[Integer, Integer]]])
  end

  sig { returns(Integer) }
  def part1
    create_antenna_map
    find_antinodes.size
  end

  sig { void }
  def create_antenna_map
    each do |x, y|
      antenna = T.must(@grid[[x, y]])
      next if antenna == '.'

      @antenna_map[antenna] ||= Set[]
      T.must(@antenna_map[antenna]) << [x, y]
    end
  end

  sig { params(all: T::Boolean).returns(T::Set[Coordinate]) }
  def find_antinodes(all: false)
    antinodes = T.let(Set[], T::Set[Coordinate])
    @antenna_map.each_value do |locations|
      locations.to_a.combination(2) do |ant1, ant2|
        antinodes.merge(antinodes_for_locations(T.must(ant1), T.must(ant2), all:).reject { out_of_bounds?(_1) })
      end
    end
    antinodes
  end

  sig { params(ant1: Coordinate, ant2: Coordinate, all: T::Boolean).returns(T::Set[Coordinate]) }
  def antinodes_for_locations(ant1, ant2, all: false)
    x1, y1 = ant1
    x2, y2 = ant2
    xdelta = x2 - x1
    ydelta = y2 - y1
    return Set[[x1 - xdelta, y1 - ydelta], [x2 + xdelta, y2 + ydelta]] unless all

    antinodes = T.let(Set[], T::Set[Coordinate])
    @grid.size.times do |i|
      new_coords = Set[[x1 - (i * xdelta), y1 - (i * ydelta)], [x2 + (i * xdelta), y2 + (i * ydelta)]]
      break if new_coords.all? { out_of_bounds?(_1) }

      antinodes.merge(new_coords)
    end
    antinodes
  end

  sig { returns(Integer) }
  def part2
    create_antenna_map
    find_antinodes(all: true).size
  end
end
