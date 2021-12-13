# frozen_string_literal: true

require_relative '../../../2021/13/transparent_origami'

RSpec.describe TransparentOrigami do
  describe '#fold(1)' do
    it 'updates dot count in test_input' do
      expect(described_class.new("#{__dir__}/test_input").fold(1).dot_count).to eq(17)
    end

    it 'updates dot count in input' do
      expect(described_class.new("#{__dir__}/input").fold(1).dot_count).to eq(755)
    end
  end

  describe '#fold' do
    it 'reveals activation code' do
      expect(described_class.new("#{__dir__}/input").fold.inspect).to eq(<<~CODE)
        ###..#....#..#...##.###..###...##...##..
        #..#.#....#.#.....#.#..#.#..#.#..#.#..#.
        ###..#....##......#.#..#.###..#..#.#....
        #..#.#....#.#.....#.###..#..#.####.#.##.
        #..#.#....#.#..#..#.#.#..#..#.#..#.#..#.
        ###..####.#..#..##..#..#.###..#..#..###.
      CODE
    end
  end
end
