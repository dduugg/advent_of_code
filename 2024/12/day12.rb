# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

class Y2024D12 < GridSolver
  Elem = type_member(:out) { { fixed: [Integer, Integer] } }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/12/#{filepath}")
    # map of plants to set of regions
    @regions = T.let({}, T::Hash[String, T::Set[T::Set[Coordinate]]])
  end

  sig { returns(Integer) }
  def part1
    populate_regions
    @regions.sum do |_, regions|
      regions.sum do |region|
        region.size * perimeter(region)
      end
    end
  end

  sig { void }
  def populate_regions
    each do |coord|
      plant = @grid.fetch(coord)
      @regions[plant] ||= Set.new
      neighbors = neighbors(coord, include_diagonals: false).to_set
      neighborhood = @regions.fetch(plant).find { |region| region.intersect?(neighbors) }
      if neighborhood
        neighborhood << coord
      else
        @regions.fetch(plant) << Set[coord]
      end
    end
  end

  sig { params(region: T::Set[Coordinate]).returns(Integer) }
  def perimeter(region)
    region.sum do |coord|
      out = 4 - neighbors(coord, include_diagonals: false).count { |neighbor| region.include?(neighbor) }
      # puts "#{coord} perim: #{out}"
      out
    end
  end

  sig { returns(Integer) }
  def part2
    0
  end
end
