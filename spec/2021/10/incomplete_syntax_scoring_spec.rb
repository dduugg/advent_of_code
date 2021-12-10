# frozen_string_literal: true

require_relative '../../../2021/10/incomplete_syntax_scoring'

RSpec.describe IncompleteSyntaxScoring do
  describe '#incomplete_chars' do
    it 'identifies the incomplete chars' do
      expect(described_class.new("#{__dir__}/test_input").incomplete_chars.map(&:join))
        .to eq(['[({([[{{', '({[<{(', '((((<{<{{', '<{[{[{{[[', '<{(['])
    end
  end

  describe '#score' do
    it 'scores the corrupt chars of test input' do
      expect(described_class.new("#{__dir__}/test_input").score).to eq(288_957)
    end

    it 'scores the corrupt chars' do
      expect(described_class.new("#{__dir__}/input").score).to eq(820_045_242)
    end
  end
end
