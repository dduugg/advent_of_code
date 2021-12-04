#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require_relative './game'

input = File.readlines("#{__dir__}/input").map(&:chomp)
numbers = input.shift.split(',').map(&:to_i)
boards = input.each_slice(6).map do |rows|
  break if rows.size != 6

  rows[1..].map { |row| row.split.map(&:to_i) }
end

Game.new(numbers, boards).play
