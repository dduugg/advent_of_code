# typed: false
# frozen_string_literal: true

require_relative '../../../2021/05/day5'

RSpec.describe HydrothermalVenture do
  it 'counts the multiple overlap grid spaces of the test file, excluding diagonals' do
    expect(described_class.run("#{__dir__}/test_input", include_diagonals: false)).to be 5
  end

  it 'counts the multiple overlap grid spaces of the actual input file, excluding diagonals' do
    expect(described_class.run("#{__dir__}/input", include_diagonals: false)).to be 6_548
  end

  it 'counts the multiple overlap grid spaces of the test file' do
    expect(described_class.run("#{__dir__}/test_input")).to be 12
  end

  it 'counts the multiple overlap grid spaces of the actual input file' do
    expect(described_class.run("#{__dir__}/input")).to be 19_663
  end
end
