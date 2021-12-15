# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 10: Syntax Scoring, part 2 ---
class IncompleteSyntaxScoring < Solver
  PAIRS = T.let({ '(' => ')', '[' => ']', '{' => '}', '<' => '>' }.freeze, T::Hash[String, String])
  POINTS = T.let({ '(' => 1, '[' => 2, '{' => 3, '<' => 4 }.freeze, T::Hash[String, Integer])

  sig { returns(T::Array[T::Array[String]]) }
  def incomplete_chars = @lines.map { self.class.incomplete_chars(_1) }.compact

  sig { returns(Integer) }
  def score
    line_scores = incomplete_chars.map { _1.reverse.reduce(0) { |sum, char| (sum * 5) + POINTS.fetch(char) } }
    line_scores.sort[line_scores.size / 2]
  end

  sig { params(line: String).returns(T.nilable(T::Array[String])) }
  def self.incomplete_chars(line)
    line.chars.each_with_object([]) do |char, stack|
      case char
      when *PAIRS.keys then stack.push(char)
      when *PAIRS.values then return nil if PAIRS[stack.pop] != char
      else raise ArgumentError, "Invalid character: #{char}"
      end
    end
  end
end
