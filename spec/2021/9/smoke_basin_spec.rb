# frozen_string_literal: true

require_relative '../../../2021/9/smoke_basin'

RSpec.describe SmokeBasin do
  describe '#low_points' do
    it 'identifies the low points of a test heightmap' do
      expect(described_class.new("#{__dir__}/test_input").low_points.tally).to eq({1=>1, 0=>1, 5=>2})
    end

    it 'identifies the low points of a heightmap' do
      expect(described_class.new("#{__dir__}/input").low_points.tally).to eq({4=>20, 0=>91, 1=>59, 2=>44, 3=>23, 6=>2, 5=>10})
    end
  end

  describe '#risk_level_sum' do
    it 'calculates the sum of the risk levels of a test heightmap' do
      expect(described_class.new("#{__dir__}/test_input").risk_level_sum).to be 15
    end

    it 'calculates the sum of the risk levels of a heightmap' do
      expect(described_class.new("#{__dir__}/input").risk_level_sum).to be 607
    end # 1737 is too high
  end
end
