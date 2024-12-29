# typed: false
# frozen_string_literal: true

require_relative '../../../2024/11/day11'

RSpec.describe Y2024D11 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').count_stones_after(25)).to eq(187_738)
    end
  end

  describe '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').count_stones_after(75)).to eq(223_767_210_249_237)
    end
  end
end
