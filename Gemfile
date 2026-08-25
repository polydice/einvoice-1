source 'https://rubygems.org'

# Specify your gem's dependencies in einvoice.gemspec
gemspec

# Integrate CodeClimate Code Coverage into TravisCI
# https://github.com/codeclimate/test-reporter/issues/413
gem 'simplecov', require: false, group: :test
gem "simplecov_json_formatter", require: false, group: :test

# Ruby 3.4 起 observer 不再是 default gem，而 factory_bot 仍然 require 它。
gem 'observer', group: :test
