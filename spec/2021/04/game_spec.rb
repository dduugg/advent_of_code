# typed: false
# frozen_string_literal: true

require_relative '../../../2021/04/game'

RSpec.describe Game do
  describe '#play' do
    it 'determines score of winning strategy' do
      expect(described_class.new("#{__dir__}/input").play_to_win).to be 11_774
    end

    it 'determines score of losing strategy' do
      expect(described_class.new("#{__dir__}/input").play_to_lose).to be 4495
    end
  end
end
