# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 6: Tuning Trouble ---
class TuningTrouble < Solver
  sig { params(width: Integer).returns(T.nilable(Integer)) }
  def packet_start_pos(width)
    @lines.fetch(0).chars.each_cons(width).with_index { |chars, i| break i + width if chars.uniq.size == width }
  end
end
