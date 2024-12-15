# typed: strict
# frozen_string_literal: true

require_relative '../../helper/grid_solver'

class Y2024D04 < GridSolver
  Elem = type_member(:out) { { fixed: [Integer, Integer] } }

  sig { params(filepath: String).void }
  def initialize(filepath = '2024/04/input')
    super
  end

  sig { returns(Integer) }
  def part1
    sum do |x1, y1|
      next 0 if @grid[[x1, y1]] != 'X'

      neighbors([x1, y1]).sum do |x2, y2|
        next 0 if @grid[[x2, y2]] != 'M'
        next 0 if @grid[[x2 + (x2 - x1), y2 + (y2 - y1)]] != 'A'

        @grid[[x2 + (2 * (x2 - x1)), y2 + (2 * (y2 - y1))]] == 'S' ? 1 : 0
      end
    end
  end

  sig { returns(Integer) }
  def part2
    sum do |x1, y1|
      next 0 if @grid[[x1, y1]] != 'A'

      neighbors([x1, y1]).sum do |x2, y2|
        # diagonals only
        next 0 if x1 == x2 || y1 == y2
        next 0 if @grid[[x2, y2]] != 'M'
        next 0 if @grid[[x1 + (x1 - x2), y1 + (y1 - y2)]] != 'S'

        diagonal = Set[
          @grid[[x1 + (x1 - x2), y2]],
          @grid[[x2, y1 + (y1 - y2)]],
        ]
        break 1 if diagonal.include?('M') && diagonal.include?('S')

        0
      end
    end
  end
end
