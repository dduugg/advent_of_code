# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 5: Supply Stacks ---
class SupplyStacks < Solver
  MOVE_9000 = ->(ships, src, dest, ct) { ct.times { ships[dest].push(ships[src].pop) } }
  MOVE_9001 = ->(ships, src, dest, ct) { ships[dest].push(*ships[src].pop(ct)) }

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @ships = Array.new((@lines.fetch(0).size + 5) / 4) { [] }
  end

  def load_ships
    @lines.each do |line|
      break unless line.include? '['

      line.chars.each_slice(4).with_index do |(_lb, letter, _rb, _sp), i|
        next if letter == ' '

        @ships[i + 1].push letter
      end
    end
    @ships.each(&:reverse!)
    self
  end

  def move_crates(lambda)
    @lines.select { _1.start_with?('move') }.each do |line|
      _m, ct, _f, src, _t, dest = line.split
      lambda.call(@ships, src.to_i, dest.to_i, ct.to_i)
    end
    self
  end

  def tops = @ships.map(&:last).join
end
