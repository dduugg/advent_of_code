# frozen_string_literal: true

require_relative '../../../2021/8/seven_segment_search'

RSpec.describe SevenSegmentSearch do
  describe '#sum_output_frequency' do
    it 'counts the appearance of selected digits' do
      expect(described_class.new("#{__dir__}/input").sum_output_frequency(1, 4, 7, 8)).to be 375
    end
  end

  describe '#sum_output' do
    it 'sums the processed input' do
      expect(described_class.new("#{__dir__}/input").sum_output).to be 1_019_355
    end
  end
end
