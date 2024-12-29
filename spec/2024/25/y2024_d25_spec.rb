# typed: false
# frozen_string_literal: true

require_relative '../../../2024/25/day25'

RSpec.describe Y2024D25 do
  describe '#part1' do
    it 'solves part one' do
      expect(described_class.new('input').part1).to eq(2854)
    end
  end
end
