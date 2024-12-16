# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

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

  def create_antenna_map
    each do |x, y|
      antenna = T.must(@grid[[x, y]])
      next if antenna == '.'

      @antenna_map[antenna] ||= Set[]
      @antenna_map[antenna] << [x, y]
    end
  end

  def find_antinodes
    antinodes = Set[]
    @antenna_map.each_value do |locations|
      locations.to_a.combination(2) do |ant1, ant2|
        antinodes.merge(antinodes_for_locations(ant1, ant2).reject { out_of_bounds?(_1) })
      end
    end
    antinodes
  end

  def antinodes_for_locations(ant1, ant2)
    x1, y1 = ant1
    x2, y2 = ant2
    xdelta = x2 - x1
    ydelta = y2 - y1
    [
      [x1 - xdelta, y1 - ydelta],
      [x2 + xdelta, y2 + ydelta]
    ]
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
