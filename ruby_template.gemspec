# typed: strict
# frozen_string_literal: true

require_relative 'lib/ruby_template/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_template'
  spec.version       = RubyTemplate::VERSION
  spec.authors       = ['Douglas Eichelberger']
  spec.email         = ['dug@testingin.productions']

  spec.summary       = 'A template for creating ruby projects'
  spec.description   = 'A template for creating ruby projects'
  spec.homepage      = 'https://github.com/dduugg/ruby_template'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage + '/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'codecov', '~> 0.1.17'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.85.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.40'
  spec.add_development_dependency 'rubocop-sorbet', '~> 0.4.0'
  spec.add_development_dependency 'simplecov', '~> 0.18.5'
  spec.add_development_dependency 'sorbet', '~> 0.5.5745'
  spec.add_runtime_dependency 'sorbet-runtime', '~> 0.5'
end
