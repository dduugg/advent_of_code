#!/usr/bin/env ruby
# typed: false
# frozen_string_literal: true

# --- Day 5: Hydrothermal Venture ---
class HydrothermalVenture
  extend T::Sig

  sig { params(filename: String, include_diagonals: T::Boolean).returns(Integer) }
  def self.run(filename, include_diagonals: true)
    input = File.readlines(filename).map(&:chomp)
    grid = Hash.new { |hash, key| hash[key] = Hash.new(0) }
    process(input, grid, include_diagonals)
    T.unsafe(grid).sum do |_, ys| # https://github.com/sorbet/sorbet/issues/4972
      ys.count { |_, c| c > 1 }
    end
  end

  sig { params(line: String).returns([Integer, Integer, Integer, Integer]) }
  def self.get_points(line)
    p1, p2 = T.cast(line.split(' -> '), [String, String])
    x1, y1 = p1.split(',').map(&:to_i)
    x2, y2 = p2.split(',').map(&:to_i)
    [T.must(x1), T.must(y1), T.must(x2), T.must(y2)]
  end

  sig do
    params(
      input: T::Array[String], grid: T::Hash[Integer, T::Hash[Integer, Integer]], include_diagonals: T::Boolean
    ).void
  end
  def self.process(input, grid, include_diagonals)
    input.each do |line|
      x1, y1, x2, y2 = get_points(line)
      if x1 != x2 && y1 != y2
        next unless include_diagonals

        process_diagonal(grid, x1, y1, x2, y2)
      else
        process_orthagonal(grid, x1, y1, x2, y2)
      end
    end
  end

  sig do
    params(grid: T::Hash[Integer, T::Hash[Integer, Integer]], x1: Integer, y1: Integer, x2: Integer, y2: Integer).void
  end
  def self.process_diagonal(grid, x1, y1, x2, y2) # rubocop:disable Naming/MethodParameterName
    xmethod = x1 < x2 ? :upto : :downto
    ymethod = y1 < y2 ? :+ : :-
    y = T.let(y1, Integer)
    x1.send(xmethod, x2) do |x|
      grid[x][y] += 1
      y = T.let(y.send(ymethod, 1), Integer)
    end
  end

  sig do
    params(grid: T::Hash[Integer, T::Hash[Integer, Integer]], x1: Integer, y1: Integer, x2: Integer, y2: Integer).void
  end
  def self.process_orthagonal(grid, x1, y1, x2, y2) # rubocop:disable Naming/MethodParameterName
    if x1 == x2
      a, b = y1 < y2 ? [y1, y2] : [y2, y1]
      (a..b).each { |y| grid[x1][y] += 1 }
    else # y1 == y2
      a, b = x1 < x2 ? [x1, x2] : [x2, x1]
      (a..b).each { |x| grid[x][y1] += 1 }
    end
  end
end
