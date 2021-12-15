# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 10: Syntax Scoring, part 1 ---
class CorruptSyntaxScoring < Solver
  PAIRS = T.let({ '(' => ')', '[' => ']', '{' => '}', '<' => '>' }.freeze, T::Hash[String, String])
  POINTS = T.let({ ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }.freeze, T::Hash[String, Integer])

  sig { returns(T::Array[String]) }
  def corrupt_chars = @lines.map { self.class.corrupt_char(_1) }.compact

  sig { returns(Integer) }
  def score = corrupt_chars.reduce(0) { |acc, c| acc + POINTS[c] }

  sig { params(line: String).returns(T.nilable(String)) }
  def self.corrupt_char(line)
    line.chars.each_with_object([]) do |char, stack|
      case char
      when *PAIRS.keys then stack.push(char)
      when *PAIRS.values then return char if PAIRS[stack.pop] != char
      else raise ArgumentError, "Invalid character: #{char}"
      end
    end
    nil
  end
end
