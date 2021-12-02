#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

input = File.readlines("#{__dir__}/input")
hpos = 0
depth = 0
lines = input.map do |line|
  pair = line.split
  [pair.first, pair.last.to_i]
end
lines.each do |line|
  case line
  in 'forward', units
    hpos += units
  in 'down', units
    depth += units
  in 'up', units
    depth -= units
  else
    puts "Unknown instruction: #{line}"
  end
end
puts hpos * depth
hpos = 0
depth = 0
aim = 0
lines.each do |line|
  case line
  in 'forward', units
    hpos += units
    depth += aim * units
  in 'down', units
    aim += units
  in 'up', units
    aim -= units
  else
    puts "Unknown instruction: #{line}"
  end
end
puts hpos * depth
