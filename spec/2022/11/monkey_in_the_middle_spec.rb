# typed: false
# frozen_string_literal: true

require_relative '../../../2022/11/monkey_in_the_middle'

RSpec.describe MonkeyInTheMiddle do
  describe '#monkey_biz' do
    it 'calculates the monkey business for part one' do
      expect(described_class.new("#{__dir__}/input").init_monkeys(3).play_rounds(20).monkey_biz).to eq(66_802)
    end

    it 'calculates the monkey business for part two' do
      expect(described_class.new("#{__dir__}/input").init_monkeys.play_rounds(10_000).monkey_biz).to eq(21_800_916_620)
    end
  end
end
