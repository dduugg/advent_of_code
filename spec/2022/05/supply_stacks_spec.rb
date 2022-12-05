# typed: false
# frozen_string_literal: true

require_relative '../../../2022/05/supply_stacks'

RSpec.describe SupplyStacks do
  describe 'finds the top crates' do
    it 'using CrateMover 9000 method' do
      expect(described_class.new("#{__dir__}/input").load_ships.move_crates(described_class::MOVE_9000).tops)
        .to eq('SPFMVDTZT')
    end

    it 'counts the ranges that overlap' do
      expect(described_class.new("#{__dir__}/input").load_ships.move_crates(described_class::MOVE_9001).tops)
        .to eq('ZFSJBPRFP')
    end
  end
end
