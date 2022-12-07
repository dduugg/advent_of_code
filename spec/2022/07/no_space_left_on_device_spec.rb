# typed: false
# frozen_string_literal: true

require_relative '../../../2022/07/no_space_left_on_device'

RSpec.describe NoSpaceLeftOnDevice do
  describe '#start_of_packet_pos' do
    it 'sum_dirs_below_threshold' do
      expect(described_class.new("#{__dir__}/input").sum_dirs(100_000)).to eq(1_749_646)
    end

    it 'finds start of packet for part 2' do
      expect(described_class.new("#{__dir__}/input").dir_size_to_del(40_000_000)).to eq(1_498_966)
    end
  end
end
