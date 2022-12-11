# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 10: Cathode-Ray Tube ---
class CathodeRayTube < Solver
  sig { returns(Integer) }
  attr_reader :signal_sum

  CRT_WIDTH = 40

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @cycle = T.let(0, Integer)
    @cycles = T.let([], T::Array[Integer])
    @register = T.let(1, Integer)
    @signal_sum = T.let(0, Integer)
    @crt = T.let([], T::Array[String])
  end

  sig { params(cycles: T::Array[Integer]).returns(CathodeRayTube) }
  def process(cycles)
    @cycles = cycles
    @lines.each { process_line(_1) }
    self
  end

  sig { params(num_cycles: Integer, value: Integer).void }
  def acc(num_cycles, value)
    num_cycles.times do |cycle|
      @crt << (((@cycle % CRT_WIDTH) - @register).abs < 2 ? '#' : '.')
      @cycle += 1
      @signal_sum += @register * T.must(@cycles.shift) if @cycle == @cycles.first
      @register += value if cycle == num_cycles - 1
    end
  end

  sig { params(line: String).void }
  def process_line(line)
    case line.split
    in ['addx', value] then acc(2, value.to_i)
    in ['noop'] then acc(1, 0)
    else raise "Unexpected line: #{line}"
    end
  end

  sig { returns(String) }
  def render = "#{@crt.each_slice(CRT_WIDTH).map(&:join).join("\n")}\n"
end
