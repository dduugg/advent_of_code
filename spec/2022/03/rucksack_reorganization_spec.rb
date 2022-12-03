# typed: false
# frozen_string_literal: true

require_relative '../../../2022/03/rucksack_reorganization'

RSpec.describe RucksackReorganization do
  describe '#item_sum' do
    it 'calculates the item sum' do
      expect(described_class.new("#{__dir__}/input").item_sum).to eq(8018)
    end
  end

  describe '#badge_sum' do
    it 'calculates the badge sum' do
      expect(described_class.new("#{__dir__}/input").badge_sum).to eq(2518)
    end
  end
end
