# typed: strong
# frozen_string_literal: true

def count_increases(arr)
  increasing_depth_tally = 0
  arr.each_with_index do |depth, i|
    next if i == 0

    increasing_depth_tally += 1 if depth > arr[i-1]
  end
  increasing_depth_tally
end

depths = File.readlines('lib/input.txt').map(&:to_i)
puts count_increases(depths)
windows = []
depths.each_with_index do |depth, i|
  next if i < 2

  windows.push(depth + depths[i-1] + depths[i-2])
end
puts count_increases(windows)
