# frozen_string_literal: true

require_relative '../../../2021/07/constant_crab_aligner'

RSpec.describe ConstantCrabAligner do
  it 'calculates the cost to align at a position with constant fuel use' do
    instance = described_class.new("#{__dir__}/test_input")
    [[1, 41], [2, 37], [3, 39], [10, 71]].each do |position, fuel_cost|
      expect(instance.fuel_cost_to_align_at(position)).to be fuel_cost
    end
  end

  it 'calculates the optimal fuel cost of test input' do
    instance = described_class.new("#{__dir__}/test_input")
    expect(instance.fuel_cost_of_optimal_alignment).to be 37
  end

  it 'calculates the optimal fuel cost' do
    instance = described_class.new("#{__dir__}/input")
    expect(instance.fuel_cost_of_optimal_alignment).to be 336_131
  end
end
