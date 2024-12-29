# typed: false
# frozen_string_literal: true

require_relative '../../../2024/12/day12'

RSpec.describe Y2024D12 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(813_768)
    end
  end

  describe '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(0)
    end
  end
end
