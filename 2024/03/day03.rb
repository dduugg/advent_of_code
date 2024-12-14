# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D03 < Solver
  sig { params(filepath: String).void }
  def initialize(filepath = '2024/03/input')
    super
  end

  sig { returns(Integer) }
  def part1 = @lines.sum { sum_muls(_1) }

  sig { returns(Integer) }
  def part2
    sublines = @lines.join.split("don't()")
    (sublines[1..]&.sum do |subline|
      sum_muls(subline.split('do()', 2)[1])
    end || 0) + sum_muls(sublines.first)
  end

  sig { params(line: T.nilable(String)).returns(Integer) }
  def sum_muls(line)
    return 0 unless line

    line.scan(/mul\((\d+),(\d+)\)/).sum do |i1, i2|
      raise "Invalid line: #{line}" if i1.is_a?(Array) || i2.is_a?(Array)

      Integer(i1) * Integer(i2)
    end
  end
end
