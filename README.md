# RubyTemplate
[![Build Status](https://travis-ci.com/dduugg/ruby_template.svg?branch=master)](https://travis-ci.com/dduugg/ruby_template)
[![codecov](https://codecov.io/gh/dduugg/ruby_template/branch/master/graph/badge.svg)](https://codecov.io/gh/dduugg/ruby_template)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ruby_template`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_template'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby_template

## Usage

Use this as the repository template when creating a new GitHub repository. Rename things to correspond to the new project, e.g.

```
git grep -l RubyTemplate | xargs gsed -i 's|RubyTemplate|Roboadvisor|g'
git grep -l ruby_template | xargs gsed -i 's|ruby_template|roboadvisor|g'
mv spec/ruby_template_spec.rb spec/roboadvisor.rb
mv ruby_template.gemspec roboadvisor.gemspec
mv lib/ruby_template lib/roboadvisor
mv lib/ruby_template.rb lib/roboadvisor.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby_template.

