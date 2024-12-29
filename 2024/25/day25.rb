# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D25 < Solver
  Pins = T.type_alias { [Integer, Integer, Integer, Integer, Integer] }

  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/25/#{filepath}")
    @keys = T.let(Set.new, T::Set[Pins])
    @locks = T.let(Set.new, T::Set[Pins])
    @lines.each_slice(8) do |slice|
      case slice[0]
      when '.....' then @keys.add(parse_slice(slice))
      when '#####' then @locks.add(parse_slice(slice))
      else raise "Unknown slice: #{slice}"
      end
    end
  end

  sig { params(slice: T::Array[String]).returns(Pins) }
  def parse_slice(slice) = T.cast(Array.new(5) { |i| slice.count { |line| line[i] == '#' } - 1 }, Pins)

  sig { params(key: Pins, lock: Pins).returns(T::Boolean) }
  def valid_pair?(key, lock) = key.zip(lock).all? { |k, l| k + T.must(l) <= 5 }

  sig { returns(Integer) }
  def part1 = @keys.sum { |key| @locks.count { |lock| valid_pair?(key, lock) } }
end
