# frozen_string_literal: false

require_relative '../../../2021/14/extended_polymerization'

RSpec.describe ExtendedPolymerization do
  describe '#diff' do
    it 'calculates diff of small step count' do
      expect(described_class.new("#{__dir__}/input").step(10).diff).to eq(3406)
    end

    it 'calculates diff of large step count' do
      expect(described_class.new("#{__dir__}/input").step(40).diff).to eq(3_941_782_230_241)
    end
  end
end
