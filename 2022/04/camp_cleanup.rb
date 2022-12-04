# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 4: Camp Cleanup ---
class CampCleanup < Solver
  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    pairs = @lines.map { _1.split(',') }.map do |pair|
      pair.map do |range|
        l, r = range.split('-').map(&:to_i)
        l..r
      end
    end
    # should be
    # @pairs = T.let(pairs, T::Array[[T::Range[Integer], T::Range[Integer]]])
    @pairs = T.let(pairs, T::Array[T::Array[T::Range[Integer]]])
  end

  sig { params(lambda: Method).returns(Integer) }
  def count_matches(lambda) = @pairs.count { |r1, r2| lambda.call(T.must(r1), T.must(r2)) }

  sig { params(ra1: T::Range[Integer], ra2: T::Range[Integer]).returns(T::Boolean) }
  def self.contains?(ra1, ra2) = ra1.cover?(ra2) || ra2.cover?(ra1)

  sig { params(ra1: T::Range[Integer], ra2: T::Range[Integer]).returns(T::Boolean) }
  def self.overlap?(ra1, ra2) = !(ra1.first > ra2.last || ra1.last < ra2.first)
end
