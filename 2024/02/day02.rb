# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D02 < Solver
  sig { returns(Integer) }
  def part1
    reports = @lines.map { |line| line.split.map(&:to_i) }
    reports.count { safe?(_1) }
  end

  sig { params(report: T::Array[Integer]).returns(T::Boolean) }
  def safe?(report)
    puts report.join(' ')
    direction = (report[1] - report[0]).positive? ? 1 : -1
    report.each_cons(2).all? do |a, b|
      diff = (b - a) * direction
      diff.positive? && diff < 4
    end
  end

  sig { returns(Integer) }
  def part2
    reports = @lines.map { |line| line.split.map(&:to_i) }
    reports.count { safe_with_bad_report?(_1) }
  end

  sig { params(report: T::Array[Integer]).returns(T::Boolean) }
  def safe_with_bad_report?(report)
    direction = calc_direction(report)
    report.size.times do |i|
      next if valid_diff?(report, i, direction)

      if i == 1
        return true if safe?(report[1..])
      elsif i == report.size - 1
        return true if safe?(report[..(i - 2)])
      end
      return safe?(report[..(i - 1)] + report[(i + 1)..])
    end
    true
  end

  def valid?(report, index, direction)
    return true if index.zero?

    diff = (report[index] - report[index - 1]) * direction
    diff.positive? || diff < 4
  end

  sig { params(report: T::Array[Integer]).returns(Integer) }
  def calc_direction(report)
    report.each_cons(2).map { |a, b| (b - a).positive? }.count { _1 } > 1 ? 1 : -1
  end
end
