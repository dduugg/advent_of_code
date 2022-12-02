# typed: false
# frozen_string_literal: true

require_relative '../../../2022/02/rock_paper_scissors'

RSpec.describe RockPaperScissors do
  describe '#total_score_p1' do
    it 'calculates the total score for part one' do
      expect(described_class.new("#{__dir__}/input.txt").total_score_p1).to eq(12_276)
    end

    it 'calculates the total score for part two' do
      expect(described_class.new("#{__dir__}/input.txt").total_score_p2).to eq(9975)
    end
  end
end
