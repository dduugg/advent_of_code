# typed: false
# frozen_string_literal: true

require_relative '../../../2024/10/day10'

RSpec.describe Y2024D10 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(789)
    end
  end

  describe '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(1735)
    end
  end
end
