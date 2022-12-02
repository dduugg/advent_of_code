# typed: false
# frozen_string_literal: true

require_relative '../../../2021/25/sea_cucumber'

RSpec.describe SeaCucumber do
  describe 'steps_until_stopped' do
    it 'counts steps_until_stopped for test input' do
      expect(described_class.new("#{__dir__}/test_input").steps_until_stopped).to eq(58)
    end

    it 'counts steps_until_stopped for input' do
      skip 'slow' if ENV['CI'] != 'true'
      expect(described_class.new("#{__dir__}/input").steps_until_stopped).to eq(426)
    end
  end
end
