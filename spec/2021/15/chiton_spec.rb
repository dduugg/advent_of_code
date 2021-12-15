# frozen_string_literal: true

require_relative '../../../2021/15/chiton'

RSpec.describe Chiton do
  describe 'finds lowest risk path' do
    it 'using a* on test input' do
      expect(described_class.new("#{__dir__}/test_input").a_star).to eq(40)
    end

    it 'using a* on input' do
      expect(described_class.new("#{__dir__}/input").a_star).to eq(508)
    end

    it 'using a* on test input with expanded grid' do
      expect(described_class.new("#{__dir__}/test_input").expand_grid.a_star).to eq(315)
    end

    it 'using a* on input with expanded grid' do
      skip 'slow' if ENV['CI'] != 'true'
      expect(described_class.new("#{__dir__}/input").expand_grid.a_star).to eq(2872)
    end
  end
end
