# typed: false
# frozen_string_literal: true

require_relative '../../../2024/08/day08'

RSpec.describe Y2024D08 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(394)
    end
  end

  describe '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(1277)
    end
  end
end
