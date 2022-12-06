# typed: false
# frozen_string_literal: true

require_relative '../../../2022/06/tuning_trouble'

RSpec.describe TuningTrouble do
  describe '#start_of_packet_pos' do
    it 'finds start of packet for part 1' do
      expect(described_class.new("#{__dir__}/input").packet_start_pos(4)).to eq(1140)
    end

    it 'finds start of packet for part 2' do
      expect(described_class.new("#{__dir__}/input").packet_start_pos(14)).to eq(3495)
    end
  end
end
