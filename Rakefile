# typed: strict
# frozen_string_literal: true

require 'dotenv/load'
require 'fileutils'
require 'net/http'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'get input for day'
task :input do
  day = ARGV[1]
  puts ENV.fetch('AOC_COOKIE')
  input = Net::HTTP.get(URI("https://adventofcode.com/2024/day/#{day}/input"), { 'Cookie' => "session=#{ENV.fetch('AOC_COOKIE')}" })
  day = "0#{day}" if day.size == 1
  FileUtils.mkdir_p("2024/#{day}")
  FileUtils.mkdir_p("spec/2024/#{day}")
  File.write("2024/#{day}/input", input)
  File.write("spec/2024/#{day}/input", input)
end

# Suppress errors for day argument to input task
# Now you can invoke "rake input 5" to e.g. get the input for day 5
25.times { task :"#{_1 + 1}" }

desc 'typecheck files with sorbet'
task :typecheck do
  sh 'srb tc helper/ 2021/ 2022/ 2024/'
end

task ci: %i[typecheck rubocop spec]
task default: %i[typecheck rubocop spec]
