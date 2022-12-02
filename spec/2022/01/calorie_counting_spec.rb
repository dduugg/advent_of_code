# typed: false
# frozen_string_literal: true

require_relative '../../../2022/01/calorie_counting'

RSpec.describe CalorieCounting do
  describe '#top_calories' do
    it 'find the calories of the elf with the most calories' do
      expect(described_class.new("#{__dir__}/input.txt").top_calories).to eq(73_211)
    end

    it 'sums the calories of the elves with the most calories' do
      expect(described_class.new("#{__dir__}/input.txt").top_calories(3)).to eq(213_958)
    end
  end
end
