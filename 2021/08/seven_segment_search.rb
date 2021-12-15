# typed: false
# frozen_string_literal: true

require 'set'
require 'sorbet-runtime'

# --- Day 8: Seven Segment Search ---
# A class determine crab alignment when fuel costs increase linearly per step
class SevenSegmentSearch
  extend T::Sig

  Digits = T.type_alias { [String, String, String, String, String, String, String, String, String, String] }
  SEGMENTS = T.let(
    [
      %w[a b c e f g],
      %w[c f],
      %w[a c d e g],
      %w[a c d f g],
      %w[b c d f],
      %w[a b d f g],
      %w[a b d e f g],
      %w[a c f],
      %w[a b c d e f g],
      %w[a b c d f g]
    ].map(&:to_set), T::Array[T::Set[String]]
  )

  sig { params(filepath: String).void }
  def initialize(filepath)
    @input = T.let(File.readlines(filepath).map(&:chomp), T::Array[String])
  end

  sig { returns(T::Array[T::Array[Integer]]) }
  def process_input
    @process_input ||= @input.map do |line|
      digits, code = line.split(' | ').map(&:split)
      digit_map = create_digit_map(digits)
      translate(code, digit_map)
    end
  end

  # Use the frequency of each segment to identify the mapping:
  # a: 8, b: 6, c: 8, d: 7, e: 4, f: 9, g: 7
  sig { params(digits: Digits).returns(T::Hash[String, String]) }
  def create_digit_map(digits)
    digits.join.chars.tally.map do |letter, count|
      case count
      when 4 then [letter, 'e']
      when 6 then [letter, 'b']
      when 7, 8 then solve_freq_collision(digits, letter, count)
      when 9 then [letter, 'f']
      end
    end.to_h
  end

  # When frequency is insufficient to decode, look for specific digits with unique lengths
  sig { params(digits: Digits, letter: String, count: Integer).returns([String, String]) }
  def solve_freq_collision(digits, letter, count)
    case count
    # 'd' appears in digit 4, which is the only digit with 4 segments
    when 7 then digits.find {_1.size == 4}.chars.include?(letter) ? [letter, 'd'] : [letter, 'g']
    # 'c' appears in digit 1, which is the only digit with 2 segments
    when 8 then digits.find {_1.size == 2}.chars.include?(letter) ? [letter, 'c'] : [letter, 'a']
    else raise ArgumentError, "Unexpected count: #{count}"
    end
  end

  sig { returns(Integer) }
  def sum_output = process_input.sum { |digits| digits.map(&:to_s).join.to_i }

  sig { params(digits: Integer).returns(Integer) }
  def sum_output_frequency(*digits) = process_input.flatten.count { digits.include?(_1) }

  sig { params(code: T::Array[String], digit_map: T::Hash[String, String]).returns(T::Array[Integer]) }
  def translate(code, digit_map)
    code.map { |segment| SEGMENTS.find_index(segment.chars.map { digit_map[_1] }.to_set) }
  end
end
