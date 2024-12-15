# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 9: Rope Bridge ---
class RopeBridge < Solver
  attr_reader :hpos, :tpos, :tail_visited

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @hpos = [0, 0]
    @tpos = [0, 0]
    @tail_visited = Set.new(@tpos)
    @steps = @lines.map(&:split).map { |d, n| [d, n.to_i] }
  end

  def apply
    @steps.each do |dir, num|
      num.times do
        case dir
        when 'L' then hpos[0] -= 1
        when 'R' then hpos[0] += 1
        when 'U' then hpos[1] -= 1
        when 'D' then hpos[1] += 1
        end
        update_tpos(dir, hpos)
      end
    end
    self
  end

  def update_tpos(dir, hpos)
    return if adj?

    case dir
    when 'L' then @tpos = [hpos[0] + 1, hpos[1]]
    when 'R' then @tpos = [hpos[0] - 1, hpos[1]]
    when 'U' then @tpos = [hpos[0], hpos[1] + 1]
    when 'D' then @tpos = [hpos[0], hpos[1] - 1]
    end
    @tail_visited << tpos
  end

  def adj? = (hpos.first - tpos.first).abs <= 1 && (hpos.last - tpos.last).abs <= 1
end
