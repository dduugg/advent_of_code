# typed: strict
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D07 < Solver
  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/07/#{filepath}")
  end

  sig { returns(Integer) }
  def part1
    @lines.sum do |line|
      target, rest = line.split(': ')
      target = target.to_i
      nums = T.must(rest).split.map(&:to_i)
      valid?(target, nums) ? target : 0
    end
  end

  sig { params(target: Integer, nums: T::Array[Integer], include_concat: T::Boolean).returns(T::Boolean) }
  def valid?(target, nums, include_concat: false)
    return false if nums.empty?
    return nums.first == target if nums.size == 1

    valid?(target, [nums.fetch(0) + nums.fetch(1)] + T.must(nums[2..]), include_concat:) ||
      valid?(target, [nums.fetch(0) * nums.fetch(1)] + T.must(nums[2..]), include_concat:) ||
      (include_concat && valid?(target, [concat(nums.fetch(0), nums.fetch(1))] + T.must(nums[2..]), include_concat:))
  end

  sig { params(num1: Integer, num2: Integer).returns(Integer) }
  def concat(num1, num2) = "#{num1}#{num2}".to_i

  sig { returns(Integer) }
  def part2
    @lines.sum do |line|
      target, rest = line.split(': ')
      target = target.to_i
      nums = T.must(rest).split.map(&:to_i)
      valid?(target, nums, include_concat: true) ? target : 0
    end
  end
end
