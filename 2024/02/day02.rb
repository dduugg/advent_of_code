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
    direction = (report.fetch(1) - report.fetch(0)).positive? ? 1 : -1
    report.each_cons(2).all? do |a, b|
      diff = (T.must(b) - T.must(a)) * direction
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
      next if valid?(report, i, direction)

      check_report(report, i)
    end
    true
  end

  sig { params(report: T::Array[Integer], index: Integer).returns(T::Boolean) }
  def check_report(report, index)
    if index == 1
      return true if safe?(T.must(report[1..]))
    elsif index == report.size - 1
      return true if safe?(T.must(report[..(index - 2)]))
    end
    safe?(T.must(report[..(index - 1)]) + T.must(report[(index + 1)..]))
  end

  sig { params(report: T::Array[Integer], index: Integer, direction: Integer).returns(T::Boolean) }
  def valid?(report, index, direction)
    return true if index.zero?

    diff = (report.fetch(index) - report.fetch(index - 1)) * direction
    diff.positive? || diff < 4
  end

  sig { params(report: T::Array[Integer]).returns(Integer) }
  def calc_direction(report)
    report.each_cons(2).map { |a, b| (T.must(b) - T.must(a)).positive? }.count { _1 } > 1 ? 1 : -1
  end
end
