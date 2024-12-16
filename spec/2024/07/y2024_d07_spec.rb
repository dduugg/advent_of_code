# typed: false
# frozen_string_literal: true

require_relative '../../../2024/07/day07'

RSpec.describe Y2024D07 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(5_837_374_519_342)
    end
  end

  describe.skip '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(492_383_931_650_959)
    end
  end
end
