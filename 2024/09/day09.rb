# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D09 < Solver
  # "pair" 🤦
  Pair = T.type_alias { [Integer, Integer, T::Boolean] }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/09/#{filepath}")
    files, spaces = @lines.fetch(0).chars.map(&:to_i).each_with_index.partition { |_, i| i.even? }
    @files = T.let(files.map { [_1.fetch(0), _1.fetch(1) / 2] }, T::Array[[Integer, Integer]])
    @spaces = T.let(spaces.map { _1.fetch(0) }, T::Array[Integer])
  end

  sig { returns(Integer) }
  def part1
    block = 0
    checksum = 0
    until @files.empty?
      blocks, id = T.must(@files.shift)
      while blocks.positive?
        checksum += id * block
        blocks -= 1
        block += 1
      end
      block, checksum = process_space(block, checksum)
    end
    checksum
  end

  sig { params(block: Integer, checksum: Integer).returns([Integer, Integer]) }
  def process_space(block, checksum)
    space_size = T.must(@spaces.shift)
    while space_size.positive?
      @files.pop if @files.fetch(-1).fetch(0).zero?
      return [block, checksum] if @files.empty?

      @files.fetch(-1)[0] -= 1
      checksum += @files.fetch(-1).fetch(1) * block
      block += 1
      space_size -= 1
    end
    [block, checksum]
  end

  sig { returns(Integer) }
  def part2
    pairs = preprocess
    calc_checksum(pairs)
  end

  sig { params(pairs: T::Array[Pair]).returns(Integer) }
  def calc_checksum(pairs)
    checksum = 0
    idx = 0
    pairs.each do |pair|
      size, id = pair
      while size.positive?
        checksum += idx * id
        size -= 1
        idx += 1
      end
    end
    checksum
  end

  sig { params(pairs: T::Array[Pair], rpair: Pair, rindex: Integer).void }
  def update(pairs, rpair, rindex)
    pairs.each_with_index do |lpair, i|
      break if i >= rindex
      next if i.zero? || lpair[1].nonzero? || lpair[0] < rpair[0]

      if lpair[0] == rpair[0]
        lpair.replace(rpair.dup)
      else
        lpair[0] -= rpair[0]
        pairs.insert(i, [rpair[0], rpair[1], true])
      end
      rpair[1] = 0
      return nil
    end
    rpair[2] = true
  end

  sig { returns(T::Array[Pair]) }
  def preprocess
    pairs = @lines.fetch(0).chars.map(&:to_i).each_with_index.map do |f, i|
      i.even? ? [f, i / 2, false] : [f, 0, true]
    end
    loop do
      pairs.to_enum.with_index.reverse_each do |rpair, rindex|
        next if rpair[2] || rpair[1].zero?

        update(pairs, rpair, rindex)
        break
      end
      break if pairs.all? { _1[2] || _1[1].zero? }
    end
    pairs
  end
end
