# typed: false
# frozen_string_literal: true

require_relative '../../../2024/06/day06'

RSpec.describe Y2024D06 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(5534)
    end
  end

  describe.skip '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(2262)
    end
  end
end
