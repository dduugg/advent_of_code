# typed: false
# frozen_string_literal: true

require_relative '../../../2022/09/rope_bridge'

RSpec.describe RopeBridge do
  describe '#tail_visited' do
    it 'counts the number of grid spots visited by rope tail' do
      expect(described_class.new("#{__dir__}/input").apply.tail_visited.size).to eq(5710)
    end
  end
end
