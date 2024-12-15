# typed: true
# frozen_string_literal: true

require_relative '../../helper/solver'

class Y2024D05 < Solver
  sig { params(filepath: String).void }
  def initialize(filepath = 'input')
    super("2024/05/#{filepath}")
    # map of page to pages that must be earlier
    @rules = T.let({}, T::Hash[Integer, T::Set[Integer]])
    @update_idx = @lines.each_with_index do |line, i|
      break i + 1 unless line.include?('|')

      l, r = line.split('|').map(&:to_i)
      @rules[T.must(l)] ||= Set[]
      @rules.fetch(T.must(l)) << T.must(r)
    end
    @incorrect_updates = T.let(Set[], T::Set[T::Array[Integer]])
  end

  sig { returns(Integer) }
  def part1
    T.must(@lines[@update_idx..]).sum do |line|
      value = process_update(line)
      @incorrect_updates << line.split(',').map(&:to_i) if value.zero?
      value
    end
  end

  sig { params(line: String).returns(Integer) }
  def process_update(line)
    pages = line.split(',').map(&:to_i)
    return 0 if pages.empty?

    seen = T.let(Set[], T::Set[Integer])
    pages.each do |page|
      if seen.include?(page) || @rules[page]&.intersect?(seen)
        @incorrect_updates << pages
        return 0
      end

      seen << page
    end
    score(pages)
  end

  sig { returns(Integer) }
  def part2
    part1
    @incorrect_updates.sum do |update|
      score(fix(update))
    end
  end

  sig { params(pages: T::Array[Integer]).returns(T::Array[Integer]) }
  def fix(pages)
    fixed = []
    pages = pages.dup
    while pages.size > 1
      next_page = pages.find do |page|
        pages.none? { |p| @rules[p]&.include?(page) }
      end
      pages.delete(T.must(next_page))
      fixed << next_page
    end
    fixed << pages.first
    fixed
  end

  sig { params(pages: T::Array[Integer]).returns(Integer) }
  def score(pages) = pages.fetch(pages.size / 2)
end
