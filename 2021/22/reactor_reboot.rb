# typed: false
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 22: Reactor Reboot ---
class ReactorReboot < Solver
  Coordinate = T.type_alias { [Integer, Integer, Integer] }
  INT_MATCHER = T.let(/-?\d+/, Regexp)

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @grid = T.let(Hash.new { |h, k| h[k] = 0 }, T::Hash[Coordinate, Integer])
  end

  sig { returns(T.self_type) }
  def run
    @lines.each do |line|
      state = line.start_with?('on') ? 1 : 0
      xr, yr, zr = extract_ranges(line)
      next if [xr, yr, zr].any? { |r| r.begin > 50 || r.end < -50 }

      flip_switches(xr, yr, zr, state)
    end
    self
  end

  sig { params(line: String).returns([T::Range[Integer], T::Range[Integer], T::Range[Integer]]) }
  def extract_ranges(line)
    line.scan(INT_MATCHER).map(&:to_i).each_slice(2).map do |low, high|
      Range.new([low, -50].max, [high, 50].min)
    end
  end

  sig { params(x_r: T::Range[Integer], y_r: T::Range[Integer], z_r: T::Range[Integer], state: Integer).void }
  def flip_switches(x_r, y_r, z_r, state)
    x_r.each { |x| y_r.each { |y| z_r.each { |z| @grid[[x, y, z]] = state } } }
  end

  sig { returns(Integer) }
  def on_count = @grid.values.count(1)
end
