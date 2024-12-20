# typed: false
# frozen_string_literal: true

require 'date'
require 'dotenv/load'
require 'erb'
require 'fileutils'
require 'net/http'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'create files advent day'
task :day do
  day = ARGV[1]
  year = ARGV[2] || Date.today.year
  input = Net::HTTP.get(
    URI("https://adventofcode.com/#{year}/day/#{day}/input"),
    { 'Cookie' => "session=#{ENV.fetch('AOC_COOKIE')}" }
  )
  day = "0#{day}" if day.size == 1
  FileUtils.mkdir_p("#{year}/#{day}")
  FileUtils.mkdir_p("spec/#{year}/#{day}")
  File.write("#{year}/#{day}/input", input)

  template = File.read('helper/template.rb.erb')
  erb_result = ERB.new(template).result(binding)
  File.write("#{year}/#{day}/day#{day}.rb", erb_result)

  spec_template = File.read('helper/spec_template.rb.erb')
  spec_erb_result = ERB.new(spec_template).result(binding)
  File.write("spec/#{year}/#{day}/y#{year}_d#{day}_spec.rb", spec_erb_result)
end

# Suppress errors for day argument to input task
# Now you can invoke "rake input 5" to e.g. get the input for day 5
25.times do |i|
  # rubocop:disable Rake/Desc
  task :"#{i + 1}"
  task :"#{Date.today.year - i}/"
  # rubocop:enable Rake/Desc
end

desc 'typecheck files with sorbet'
task :typecheck do
  sh 'srb tc'
end

task ci: %i[typecheck rubocop spec]
task default: %i[typecheck rubocop spec]
