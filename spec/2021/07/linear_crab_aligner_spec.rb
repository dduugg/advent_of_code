# frozen_string_literal: true

require_relative '../../../2021/07/linear_crab_aligner'

RSpec.describe LinearCrabAligner do
  it 'calculates the cost to align at a position with linearly increasing fuel use' do
    instance = described_class.new("#{__dir__}/test_input")
    [[5, 168], [2, 206]].each do |position, fuel_cost|
      expect(instance.fuel_cost_to_align_at(position)).to be fuel_cost
    end
  end

  it 'calculates the optimal fuel cost of test input' do
    instance = described_class.new("#{__dir__}/test_input")
    expect(instance.fuel_cost_of_optimal_alignment).to be 168
  end

  it 'calculates the optimal fuel cost' do
    instance = described_class.new("#{__dir__}/input")
    expect(instance.fuel_cost_of_optimal_alignment).to be 92_676_646
  end
end
