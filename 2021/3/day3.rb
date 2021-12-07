# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 3: Binary Diagnostic ---
class BinaryDiagnostic
  extend T::Sig

  sig { params(pathname: String).void }
  def initialize(pathname)
    @lines = File.readlines(pathname).map(&:chomp)
    @width = @lines.fetch(0).size
  end

  sig { params(comparator: Symbol).returns(Integer) }
  def get_rating_using(comparator)
    rating_lines = @lines.clone
    (0...rating_lines.fetch(0).size).each do |i|
      parts = rating_lines.partition { _1[i] == '0' }
      digit = parts[0].size.public_send(comparator, parts[1].size) ? 0 : 1
      rating_lines = parts[digit]
      break if rating_lines.size == 1
    end
    rating_lines.fetch(0).to_i(2)
  end

  sig { returns(Integer) }
  def rating_product
    oxygen_generator_rating = get_rating_using(:>)
    co2_scrubber_rating = get_rating_using(:<=)
    oxygen_generator_rating * co2_scrubber_rating
  end

  sig { returns(Integer) }
  def gamma_epsilon_product
    gamma = @lines.each_with_object(Array.new(@width, 0)) do |line, memo|
      process_gamma_line(line, memo)
    end
    gamma.map! { |i| i.positive? ? 1 : 0 }
    epsilon = gamma.map { _1 ^ 1}
    gamma.join.to_i(2) * epsilon.join.to_i(2)
  end

  sig { params(line: String, memo: T::Array[Integer]).void }
  def process_gamma_line(line, memo)
    line.chars.each_with_index.map do |char, index|
      char == '1' ? memo[index] += 1 : memo[index] -= 1
    end
  end
end
