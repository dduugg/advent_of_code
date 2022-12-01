# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 1: Calorie Counting ---
class CalorieCounting
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    @elves = T.let(
      File.read(filepath).split("\n\n").map { _1.split("\n").map(&:to_i) },
      T::Array[T::Array[Integer]]
    )
  end

  sig { params(num: Integer).returns(Integer) }
  def top_calories(num = 1) = @elves.map(&:sum).max_by(num) { _1 }.sum
end
