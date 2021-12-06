# frozen_string_literal: true

require_relative '../../../2021/6/lanternfish'

RSpec.describe Lanternfish do
  it 'counts test population at a date in the future' do
    expect(described_class.new("#{__dir__}/test_input").count_at_day(18)).to be 26
  end

  it 'counts test population at a date further in the future' do
    expect(described_class.new("#{__dir__}/test_input").count_at_day(80)).to be 5934
  end

  it 'counts population at a date in the future' do
    expect(described_class.new("#{__dir__}/input").count_at_day(80)).to be 343_441
  end

  it 'counts population at a date farther the future' do
    expect(described_class.new("#{__dir__}/input").count_at_day(256)).to be 1_569_108_373_832
  end
end
