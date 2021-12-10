# frozen_string_literal: true

require_relative '../../../2021/10/corrupt_syntax_scoring'

RSpec.describe CorruptSyntaxScoring do
  describe '#corrupt_chars' do
    it 'identifies the corrupt chars' do
      expect(described_class.new("#{__dir__}/test_input").corrupt_chars).to eq(['}', ')', ']', ')', '>'])
    end
  end

  describe '#score' do
    it 'scores the corrupt chars of test input' do
      expect(described_class.new("#{__dir__}/test_input").score).to eq(26_397)
    end

    it 'scores the corrupt chars' do
      expect(described_class.new("#{__dir__}/input").score).to eq(288_291)
    end
  end
end
