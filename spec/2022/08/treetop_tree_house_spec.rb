# typed: false
# frozen_string_literal: true

require_relative '../../../2022/08/treetop_tree_house'

RSpec.describe TreetopTreeHouse do
  describe '#num_visible' do
    it 'counts the number of trees visible from outside the grid' do
      expect(described_class.new("#{__dir__}/input").num_visible).to eq(1803)
    end
  end

  describe '#max_viewing_product' do
    it 'calculates the maximum product of the visible trees' do
      expect(described_class.new("#{__dir__}/input").max_viewing_product).to eq(268_912)
    end
  end
end
