# typed: strict
# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'typecheck files with sorbet'
task :typecheck do
  Dir['2021/**'].each do |dir|
    sh "srb tc #{dir}"
  end
end

task ci: %i[typecheck rubocop spec]
task default: %i[typecheck rubocop spec]
