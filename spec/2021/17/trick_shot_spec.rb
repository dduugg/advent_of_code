# typed: false
# frozen_string_literal: true

require_relative '../../../2021/17/trick_shot'

RSpec.describe TrickShot do
  describe 'max_y_pos' do
    it 'calculates the max y position of a probe that lands in trench' do
      expect(described_class.new("#{__dir__}/input").max_y_pos).to eq(4656)
    end
  end

  describe 'starting_velocities_count' do
    it 'counts the number of starting velocitis that land probe in trench' do
      expect(described_class.new("#{__dir__}/input").starting_velocities_count).to eq(1908)
    end
  end
end
