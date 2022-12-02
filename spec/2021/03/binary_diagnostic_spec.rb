# typed: false
# frozen_string_literal: true

require_relative '../../../2021/03/day3'

RSpec.describe BinaryDiagnostic do
  it 'calculated gamma * epsilon' do
    expect(described_class.new("#{__dir__}/input").gamma_epsilon_product).to be 693_486
  end

  it 'calculates rating product' do
    expect(described_class.new("#{__dir__}/input").rating_product).to be 3_379_326
  end
end
