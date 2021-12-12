# typed: strict
# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'typecheck files with sorbet'
task :typecheck do
  sh 'srb tc helper/ 2021/'
end

task ci: %i[typecheck rubocop spec]
task default: %i[typecheck rubocop spec]
