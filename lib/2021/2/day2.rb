#!/usr/bin/env ruby
# typed: strong
# frozen_string_literal: true

input = File.readlines('input')
hpos = 0
vpos = 0
lines = input.map do |line|
  pair = line.split
  [pair.first, pair.last.to_i]
end
lines.each do |line|
  case line
  in 'forward', units
    hpos += units
  in 'down', units
    vpos += units
  in 'up', units
    vpos -= units
  else
    puts "Unknown instruction: #{line}"
  end
end
puts hpos * vpos
