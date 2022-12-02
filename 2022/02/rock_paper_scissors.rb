# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 2: Rock Paper Scissors ---
class RockPaperScissors < Solver
  sig { returns(Integer) }
  def total_score_p1 = @lines.sum { move_score_p1(_1) + result_score_p1(_1) }

  sig { params(game: String).returns(Integer) }
  def move_score_p1(game) = T.must(game[-1]).ord - 'W'.ord

  sig { params(game: String).returns(Integer) }
  def result_score_p1(game)
    case game
    when 'A X', 'B Y', 'C Z' then 3
    when 'B X', 'C Y', 'A Z' then 0
    when 'C X', 'A Y', 'B Z' then 6
    else raise ArgumentError, game
    end
  end

  sig { returns(Integer) }
  def total_score_p2 = @lines.sum { move_score_p2(_1) + result_score_p2(_1) }

  sig { params(game: String).returns(Integer) }
  def move_score_p2(game)
    case game
    when 'A Y', 'B X', 'C Z' then 1
    when 'A Z', 'B Y', 'C X' then 2
    when 'A X', 'B Z', 'C Y' then 3
    else raise ArgumentError, game
    end
  end

  sig { params(game: String).returns(Integer) }
  def result_score_p2(game) = (T.must(game[-1]).ord - 'X'.ord) * 3
end
