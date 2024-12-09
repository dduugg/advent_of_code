# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D03 < Solver
  sig { params(filepath: String).void }
  def initialize(filepath = '2024/03/input')
    super
  end

  sig { returns(Integer) }
  def part1 = @lines.sum { sum_muls(it) }

  sig { returns(Integer) }
  def part2
    sublines = @lines.join.split("don't()")
    sum_muls(sublines.first) + sublines[1..].sum do |subline|
      sum_muls(subline.split('do()', 2)[1])
    end
  end

  def sum_muls(line)
    line&.scan(/mul\((\d+),(\d+)\)/)&.sum do |i1, i2|
      i1.to_i * i2.to_i
    end || 0
  end
end
