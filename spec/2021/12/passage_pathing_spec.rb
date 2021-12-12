# frozen_string_literal: true

require_relative '../../../2021/12/passage_pathing'

RSpec.describe PassagePathing do
  describe '#count_paths' do
    it 'counts the number of paths through the test grid' do
      expect(described_class.new("#{__dir__}/test_input").count_paths).to eq(19)
    end

    it 'counts the number of paths' do
      expect(described_class.new("#{__dir__}/input").count_paths).to eq(4792)
    end

    it 'counts the number of paths through the test grid with revisit' do
      expect(described_class.new("#{__dir__}/test_input").count_paths(revisit: true)).to eq(103)
    end

    it 'counts the number of paths with revisit', skip: 'slow' do
      expect(described_class.new("#{__dir__}/input").count_paths(revisit: true)).to eq(133_360)
    end
  end
end
