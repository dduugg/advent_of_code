# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 1: Historian Hysteria ---
class HistorianHysteria < Solver
  sig { returns(Integer) }
  def part_1
    list1, list2 = to_lists
    list1.sort!
    list2.sort!
    list1.zip(list2).map { |a, b| (a - b).abs }.sum
  end

  sig { returns(Integer) }
  def part_2
    list1, list2 = to_lists
    table = list2.tally
    list1.map { |n| n * table.fetch(n, 0) }.sum
  end

  sig { returns([T::Array[Integer], T::Array[Integer]]) }
  def to_lists
    @lines.reduce([[], []]) do |(l1, l2), line|
      line.split.map(&:to_i).each_cons(2) do |a, b|
        l1 << a
        l2 << b
      end
      [l1, l2]
    end
  end
end
