#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 1: Sonar Sweep ---
class SonarSweep
  extend T::Sig

  sig { params(arr: T::Array[Integer]).returns(Integer) }
  def self.count_increases(arr)
    increasing_depth_tally = 0
    arr.each_with_index do |depth, i|
      next if i.zero?

      increasing_depth_tally += 1 if depth > arr.fetch(i - 1)
    end
    increasing_depth_tally
  end

  sig { void }
  def self.run
    depths = File.readlines("#{__dir__}/input").map(&:to_i)
    puts count_increases(depths)
    windows = []
    depths.each_with_index do |depth, i|
      next if i < 2

      windows.push(depth + depths.fetch(i - 1) + depths.fetch(i - 2))
    end
    puts count_increases(windows)
  end
end

SonarSweep.run
