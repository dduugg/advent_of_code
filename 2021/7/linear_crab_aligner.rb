# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 7: The Treachery of Whales ---
# A class determine crab alignment when fuel costs increase linearly per step
class LinearCrabAligner
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    @crab_positions = T.let(File.readlines(filepath).fetch(0).chomp.split(',').map(&:to_i), T::Array[Integer])
  end

  sig { params(position: Integer).returns(Integer) }
  def fuel_cost_to_align_at(position)
    @crab_positions.sum do |crab_position|
      n = (crab_position - position).abs
      n * (n + 1) / 2
    end
  end

  sig { returns(Integer) }
  def fuel_cost_of_optimal_alignment
    foo = optimal_alignment
    fuel_cost_to_align_at(foo)
  end

  # brute force, but it works
  sig { returns(Integer) }
  def optimal_alignment
    low, high = @crab_positions.minmax
    (low..high).min { |a, b| fuel_cost_to_align_at(a) <=> fuel_cost_to_align_at(b) }
  end
end
