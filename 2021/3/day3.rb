#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 3: Binary Diagnostic ---
class BinaryDiagnostic
  extend T::Sig

  sig { params(comparator: Symbol).returns(String) }
  def self.get_rating_using(comparator)
    rating_lines = File.readlines("#{__dir__}/input").map(&:chomp)
    rating = []
    (0...rating_lines.fetch(0).size).each do |i|
      parts = rating_lines.partition { _1[i] == '0' }
      if parts[0].size.public_send(comparator, parts[1].size)
        rating[i] = 0
        rating_lines = parts[0]
      else
        rating[i] = 1
        rating_lines = parts[1]
      end
      break if rating_lines.size == 1
    end
    rating_lines.fetch(0)
  end

  sig { void }
  def self.run
    input = File.readlines("#{__dir__}/input").map(&:chomp)
    width = input.fetch(0).size
    acc = Array.new(width, 0)
    gamma = input.each_with_object(acc) do |line, memo|
      line.chars.each_with_index.map do |char, index|
        char == '1' ? memo[index] += 1 : memo[index] -= 1
      end
    end.map { |i| i.positive? ? 1 : 0 }
    epsilon = gamma.map { _1 ^ 1}
    gamma = gamma.join.to_i(2)
    epsilon = epsilon.join.to_i(2)
    puts gamma * epsilon

    oxygen_generator_rating = get_rating_using(:>)
    co2_scrubber_rating = get_rating_using(:<=)
    ogr = oxygen_generator_rating.to_i(2)
    csr = co2_scrubber_rating.to_i(2)
    puts ogr * csr
  end
end

BinaryDiagnostic.run
