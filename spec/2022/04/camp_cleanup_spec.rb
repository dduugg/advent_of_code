# typed: false
# frozen_string_literal: true

require_relative '../../../2022/04/camp_cleanup'

RSpec.describe CampCleanup do
  describe 'count_overlap' do
    it 'counts the ranges that contain another' do
      expect(described_class.new("#{__dir__}/input").count_matches(described_class.method(:contains?))).to eq(602)
    end

    it 'counts the ranges that overlap' do
      expect(described_class.new("#{__dir__}/input").count_matches(described_class.method(:overlap?))).to eq(891)
    end
  end
end
