# typed: strong
# frozen_string_literal: true

require 'sorbet-runtime'
require_relative './core_ext/queue'

# A general solver for Advent of Code problems
# @see https://adventofcode.com/ Advent of Code
class Solver
  extend T::Sig

  sig { params(filepath: String).void }
  def initialize(filepath)
    @lines = T.let(File.readlines(filepath).map(&:chomp), T::Array[String])
  end
end
