# typed: false
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 14: Extended Polymerization ---
class ExtendedPolymerization < Solver
  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @template = T.let(@lines.fetch(0).chomp, String)
    @pairs = T.let(Hash.new { _1[_2] = 0 }, T::Hash[String, Integer])
    @rules = T.let(@lines[2..].map { _1.split(' -> ') }.to_h, T::Hash[String, String])
    init_pairs
  end

  sig { void }
  def init_pairs = (@template.size - 1).times { @pairs[@template[_1.._1 + 1]] += 1 }

  sig { params(num_steps: Integer).returns(T.self_type) }
  def step(num_steps)
    num_steps.times { take_step }
    self
  end

  sig { void }
  def take_step
    pairs_next = Hash.new { _1[_2] = 0 }
    @pairs.each do |k, v|
      if @rules[k]
        pairs_next["#{k[0]}#{@rules[k]}"] += v
        pairs_next["#{@rules[k]}#{k[-1]}"] += v
      else
        pairs_next[k] += v
      end
    end
    @pairs = pairs_next
  end

  sig { returns(Integer) }
  def diff
    freq = Hash.new { _1[_2] = 0 }
    @pairs.each { freq[_1[0]] += _2 } # count first char of each pair
    freq[@template[-1]] += 1 # count last char of template
    freq.max_by { _2 }.last - freq.min_by { _2 }.last
  end
end
