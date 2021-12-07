# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 7: The Treachery of Whales ---
# A class determine crab alignment when fuel costs are constant per step
class ConstantCrabAligner
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    @crab_positions = File.readlines(filepath).first.chomp.split(',').map(&:to_i).sort
  end

  sig { params(position: Integer).returns(Integer) }
  def fuel_cost_to_align_at(position)
    @crab_positions.sum { |crab_position| (crab_position - position).abs }
  end

  sig { returns(Integer) }
  def fuel_cost_of_optimal_alignment
    if @crab_positions.size.even?
      mid = (@crab_positions.size / 2)
      align_at = (@crab_positions[mid - 1] + @crab_positions[mid]) / 2
    else
      align_at = @crab_positions[@crab_positions.size / 2]
    end
    fuel_cost_to_align_at(align_at)
  end
end
