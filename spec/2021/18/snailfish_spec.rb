# typed: false
# frozen_string_literal: true

require_relative '../../../2021/18/snailfish'

RSpec.describe Snailfish do
  describe 'explode' do
    it 'performs a single explode' do
      tree = described_class.to_tree([[[[[9, 8], 1], 2], 3], 4])
      tree.explode
      expect(tree.to_a).to eq([[[[0, 9], 2], 3], 4])
    end
  end

  describe 'split' do
    it 'splits a tree' do
      tree = described_class.to_tree([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])
      tree.split
      expect(tree.to_a).to eq([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])
    end
  end

  describe 'magnitude' do
    it 'calculates the magnitude of a snailfish number' do
      tree = described_class.to_tree([[[[6, 6], [7, 6]], [[7, 7], [7, 0]]], [[[7, 7], [7, 7]], [[7, 8], [9, 9]]]])
      expect(tree.magnitude).to eq(4140)
    end
  end

  describe 'pair_to_explode' do
    it 'finds pair to explode' do
      tree = described_class.to_tree([[[[0, 7], 4], [7, [[8, 4], 9]]], [1, 1]])
      expect(tree.pair_to_explode.to_a).to eq([8, 4])
    end
  end

  describe 'leaves' do
    it 'finds all nodes with values in DFS order' do
      tree = described_class.to_tree([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])
      expect(tree.leaves.map(&:value)).to eq([0, 7, 4, 15, 0, 13, 1, 1])
    end
  end

  describe '+' do
    it 'sums and reduces two Snailfish numbers' do
      left = described_class.to_tree([[[[4, 3], 4], 4], [7, [[8, 4], 9]]])
      right = described_class.to_tree([1, 1])
      expect((left + right).to_a).to eq([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])
    end
  end

  describe 'sum' do
    it 'sums test input' do
      expect(described_class.new("#{__dir__}/test_input").sum.magnitude).to eq(4140)
    end

    it 'sums input' do
      expect(described_class.new("#{__dir__}/input").sum.magnitude).to eq(4435)
    end
  end

  describe 'max_magnitude' do
    it 'finds the max magnitude of test input' do
      expect(described_class.new("#{__dir__}/test_input").max_magnitude).to eq(3993)
    end
  end
end
