# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D11 < Solver
  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/11/#{filepath}")
    @stones = T.let(@lines.fetch(0).split.map(&:to_i), T::Array[Integer])
    @cache = T.let({}, T::Hash[[Integer, Integer], T::Array[Integer]])
  end

  sig { params(stone: Integer).returns(T::Array[Integer]) }
  def blink(stone)
    return [1] if stone.zero?

    str = stone.to_s
    if str.size.even?
      [str[0..((str.size / 2) - 1)].to_i, str[(str.size / 2)..].to_i]
    else
      [stone * 2024]
    end
  end

  sig { params(iterations: Integer).returns(Integer) }
  def count_stones_after(iterations)
    stones = @stones.tally
    iterations.times do
      to_blink = stones.dup
      to_blink.each do |k, v|
        next if v.zero?

        blink(k).each { |stone| stones[stone] = stones.fetch(stone, 0) + v }
        stones[k] = stones.fetch(k) - v
      end
    end
    stones.values.sum
  end
end
