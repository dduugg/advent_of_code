# typed: false
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 17: Trick Shot ---
class TrickShot < Solver
  INT_CAPTURE = '(-?[[:digit:]]+)'
  RANGES_REGEX = /#{INT_CAPTURE}\.\.#{INT_CAPTURE}, y=#{INT_CAPTURE}\.\.#{INT_CAPTURE}/

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    x0, x1, y0, y1 = @lines.fetch(0).match(RANGES_REGEX)[1..].map(&:to_i)
    @x_trench = T.let(x0..x1, T::Range[Integer])
    @y_trench = T.let(y0..y1, T::Range[Integer])
    @max_y_velocity = T.let(@y_trench.min.abs - 1, Integer)
  end

  sig { returns(Integer) }
  def max_y_pos = @max_y_velocity * (@max_y_velocity + 1) / 2

  sig { returns(Integer) }
  def starting_velocities_count
    y_range = @y_trench.min..@max_y_velocity
    (@x_trench.last + 1).times.sum do |x|
      y_range.sum { |y| valid_starting_velocity?(x, y) ? 1 : 0 }
    end
  end

  sig { params(v_x: Integer, v_y: Integer).returns(T::Boolean) }
  def valid_starting_velocity?(v_x, v_y)
    x = 0
    y = 0
    loop do
      break true if @x_trench.include?(x) && @y_trench.include?(y)

      x += v_x
      y += v_y
      v_x -= 1 if v_x.positive?
      v_y -= 1

      break false if x > @x_trench.max || y < @y_trench.min
    end
  end
end
