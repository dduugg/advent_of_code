# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

# --- Day 11: Monkey in the Middle ---
class MonkeyInTheMiddle < Solver
  class Monkey < T::Struct
    prop :items, T::Array[Integer]
    const :operation, T.proc.params(arg0: Integer).returns(Integer)
    const :test, Integer
    const :if_true, Integer
    const :if_false, Integer
    prop :num_inspected, Integer, default: 0
  end

  sig { params(filepath: String).void }
  def initialize(filepath)
    super
    @monkeys = T.let([], T::Array[Monkey])
  end

  def init_monkeys(divisor = nil)
    @lines.each_slice(7) { @monkeys << make_monkey(_1) }
    init_relieve(divisor)
    self
  end

  def make_monkey(lines)
    items = T.cast(lines.fetch(1).scan(/[[:digit:]]+/), T::Array[String]).map(&:to_i)
    # 🙈
    operation = send(:eval, "lambda { |old| #{lines.fetch(2).scan(/old.+/).fetch(0)} }")
    test = extract_int(lines.fetch(3))
    if_true = extract_int(lines.fetch(4))
    if_false = extract_int(lines.fetch(5))
    Monkey.new(items:, operation:, test:, if_true:, if_false:)
  end

  def init_relieve(divisor)
    if divisor
      @relieve = -> { _1 / 3 }
    else
      divisor = @monkeys.map(&:test).reduce(&:*)
      @relieve = -> { _1 % divisor }
    end
  end

  def extract_int(str) = str.scan(/[[:digit:]]+/).fetch(0).to_i

  def play_rounds(num_rounds)
    num_rounds.times { @monkeys.each { take_turn(_1) } }
    self
  end

  def take_turn(monkey) = (inspect(monkey, monkey.items.shift) until monkey.items.empty?)

  def inspect(monkey, item)
    worry = @relieve.call(monkey.operation.call(item))
    pass_to = (worry % monkey.test).zero? ? monkey.if_true : monkey.if_false
    @monkeys.fetch(pass_to).items << worry
    monkey.num_inspected += 1
  end

  def monkey_biz = @monkeys.max_by(2, &:num_inspected).map(&:num_inspected).reduce(&:*)
end
