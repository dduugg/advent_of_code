# typed: false
# frozen_string_literal: true

require_relative '../../../2021/11/dumbo_octopus'

RSpec.describe DumboOctopus do
  describe '#step' do
    it 'advances the grid' do
      expect(described_class.new("#{__dir__}/test_input").step(3).inspect).to eq(
        "0050900866\n8500800575\n9900000039\n9700000041\n9935080063\n" \
        "7712300000\n7911250009\n2211130000\n0421125000\n0021119000\n"
      )
    end
  end

  describe '#flash_count' do
    it 'counts the cumulative flashes from grid steps using test input' do
      expect(described_class.new("#{__dir__}/test_input").step(100).flash_count).to be(1656)
    end

    it 'counts the cumulative flashes from grid steps' do
      expect(described_class.new("#{__dir__}/input").step(100).flash_count).to be(1594)
    end
  end

  describe '#steps_until_synchronized' do
    it 'counts steps until test input is synchronized' do
      expect(described_class.new("#{__dir__}/test_input").steps_until_synchronized).to eq(195)
    end

    it 'counts steps until input is synchronized' do
      expect(described_class.new("#{__dir__}/input").steps_until_synchronized).to eq(437)
    end
  end
end
