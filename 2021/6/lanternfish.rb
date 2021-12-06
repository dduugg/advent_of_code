# frozen_string_literal: true

require 'sorbet-runtime'

# --- Day 6: Lanternfish ---
class Lanternfish
  extend T::Sig

  Population = T.type_alias { [Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer] }

  sig { params(filepath: String).void }
  def initialize(filepath)
    @days = T.let([], T::Array[Population])
    @days[0] = parse_starting_file(filepath)
  end

  sig { params(day: Integer).returns(Integer) }
  def count_at_day(day)
    return @days[day].sum if @days[day]

    (1..day).each do |i|
      next if @days[i]

      @days[i] = self.class.increment_day(@days[i - 1])
    end
    @days[day].sum
  end

  sig { params(filename: String).returns(Population) }
  def parse_starting_file(filename)
    populations = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    File.readlines(filename).first.chomp.split(',').map(&:to_i).each { |day| populations[day] += 1 }
    populations
  end

  sig { params(population: Population).returns(Population) }
  def self.increment_day(population)
    [population[1], population[2], population[3], population[4], population[5],
     population[6], population[7] + population[0], population[8], population[0]]
  end
end
