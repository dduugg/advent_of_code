# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 3: Rucksack Reorganization ---
class RucksackReorganization < Solver
  sig { returns(Integer) }
  def item_sum = score(@lines.map(&:chars).map { _1.each_slice(_1.size / 2) }.map { T.must(_1.reduce(&:&)).fetch(0) })

  sig { returns(Integer) }
  def badge_sum = score(@lines.map(&:chars).each_slice(3).map { T.must(_1.reduce(&:&)).fetch(0) })

  sig { params(letters: T::Array[String]).returns(Integer) }
  def score(letters) = letters.map { _1.downcase == _1 ? _1.ord - 96 : _1.ord - 38 }.sum
end
