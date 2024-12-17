# typed: false
# frozen_string_literal: true

require_relative '../../../2024/09/day09'

RSpec.describe Y2024D09 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(6446899523367)
    end
  end

  describe.skip '#part2' do
    it 'solves part two' do
      expect(described_class.new('input').part2).to eq(6478232739671)
    end
  end
end
