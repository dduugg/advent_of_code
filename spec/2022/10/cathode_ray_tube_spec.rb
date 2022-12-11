# typed: false
# frozen_string_literal: true

require_relative '../../../2022/10/cathode_ray_tube'

RSpec.describe CathodeRayTube do
  describe '#tail_visited' do
    it 'counts the number of grid spots visited by rope tail' do
      expect(described_class.new("#{__dir__}/input").process([20, 60, 100, 140, 180, 220]).signal_sum).to eq(17_180)
    end

    it 'renders the CRT' do
      expect(described_class.new("#{__dir__}/input").process([]).render).to eq(<<~STR)
        ###..####.#..#.###..###..#....#..#.###..
        #..#.#....#..#.#..#.#..#.#....#..#.#..#.
        #..#.###..####.#..#.#..#.#....#..#.###..
        ###..#....#..#.###..###..#....#..#.#..#.
        #.#..#....#..#.#....#.#..#....#..#.#..#.
        #..#.####.#..#.#....#..#.####..##..###..
      STR
    end
  end
end
